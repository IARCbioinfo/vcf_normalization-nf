#! /usr/bin/env nextflow

//vim: syntax=groovy -*- mode: groovy;-*-

// Copyright (C) 2017 IARC/WHO

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

params.help = null
params.vcf_folder = null
params.ref = null
params.output_folder = "vt_VCF"

log.info ""
log.info "--------------------------------------------------------"
log.info "  vt-nf v2.0: Nextflow pipeline for vt normalization    "
log.info "--------------------------------------------------------"
log.info "Copyright (C) IARC/WHO"
log.info "This program comes with ABSOLUTELY NO WARRANTY; for details see LICENSE"
log.info "This is free software, and you are welcome to redistribute it"
log.info "under certain conditions; see LICENSE for details."
log.info "--------------------------------------------------------"
log.info ""

if (params.help) {
    log.info ''
    log.info '--------------------------------------------------'
    log.info '  USAGE              '
    log.info '--------------------------------------------------'
    log.info ''
    log.info 'Usage: '
    log.info 'nextflow run iarcbioinf/vt-nf --vcf_folder VCF/ --ref ref.fasta'
    log.info ''
    log.info 'Mandatory arguments:'
    log.info '    --vcf_folder         FOLDER                  Folder containing VCF files.'
    log.info '    --ref                FILE (with index)       Reference fasta file indexed.'
    log.info 'Optional arguments:'
    log.info '    --output_folder      FOLDER                  Output folder (default: vt_VCF).'
    log.info ''
    exit 1
}

assert (params.ref != true) && (params.ref != null) : "please specify --ref option (--ref reference.fasta(.gz))"

assert (params.vcf_folder != true) && (params.vcf_folder != null) : "please specify --vcf_folder option"

fasta_ref = file(params.ref)
fasta_ref_fai = file( params.ref+'.fai' )

try { assert fasta_ref.exists() : "\n WARNING : fasta reference not located in execution directory. Make sure reference index is in the same folder as fasta reference" } catch (AssertionError e) { println e.getMessage() }
if (fasta_ref.exists()) {assert fasta_ref_fai.exists() : "input fasta reference does not seem to have a .fai index (use samtools faidx)"}

try { assert file(params.vcf_folder).exists() : "\n WARNING : input VCF folder not located in execution directory" } catch (AssertionError e) { println e.getMessage() }

// recovering of vcf files
vcf = Channel.fromPath( params.vcf_folder+'/*.vcf*' )
  .ifEmpty { error "Cannot find any vcf file in: ${params.vcf_folder}" }

process vt {

    tag { vcf_tag }

    publishDir params.output_folder, mode: 'move'

    input:
    file vcf
    file fasta_ref
    file fasta_ref_fai

    output:
    file("${vcf_tag}_vt.vcf.gz") into vt_VCF

    shell:
    vcf_tag = vcf.baseName.replace(".vcf","")
    '''
    vcf-sort !{vcf_tag}.vcf.gz | vt decompose -s - | vt decompose_blocksub -a - | vt normalize -r !{fasta_ref} -q - | vt uniq - | bgzip -c > !{vcf_tag}_vt.vcf.gz
    '''
}
