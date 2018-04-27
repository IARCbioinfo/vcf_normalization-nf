# vt-nf

## Nextflow pipeline for vt normalization

![Workflow representation](vt-nf.png)

## Description

Apply [vt](https://github.com/atks/vt) to decompose and normalize variants from a set of VCF (compressed with gzip/bgzip).

This scripts takes a set of a folder containing [compressed VCF files](https://samtools.github.io/hts-specs/VCFv4.2.pdf) (`*.vcf.gz`) as an input.
It consists at four piped steps:  
  * decomposition of haplotypes (`vt decompose`)
  * decomposition of variant blocks (`vt decompose_blocksub`)
  * normalization with reference (`vt normalize`)
  * compression with bgzip (`bgzip`)



## Dependencies

1. This pipeline is based on [nextflow](https://www.nextflow.io). As we have several nextflow pipelines, we have centralized the common information in the [IARC-nf](https://github.com/IARCbioinfo/IARC-nf) repository. Please read it carefully as it contains essential information for the installation, basic usage and configuration of nextflow and our pipelines.

2. External software:  
  * [vt](https://github.com/atks/vt)  
  * [bgzip and tabix](http://www.htslib.org) from `samtools/htslib`  

 **Caution**: `vt`, `tabix` and `bgzip` have to be in your $PATH. Try each of the commands `vt`, `tabix` and `bgzip`, if it returns the options this is ok.

## Input

| Name      | Description   |
|-----------|---------------|
| `--vcf_folder`    | Folder containing tumor zipped VCF files |


## Parameters

  * #### Mandatory

| Name      | Example value | Description     |
|-----------|---------------|-----------------|
| `--ref`    | `/path/to/ref.fasta` |  Reference fasta file indexed

  * #### Optional

| Name      | Default value | Description     |
|-----------|---------------|-----------------|
| `--output_folder`    |  `vt_VCF/`  | Folder to output resulting compressed vcf |

  * #### Flags

Flags are special parameters without value.

| Name      | Description     |
|-----------|-----------------|
| `--help`    | Display help |

## Usage

Simple use case example:
```bash
nextflow run iarcbioinfo/vt-nf --vcf_folder VCF/ --ref ref.fasta
```

## Output
  | Type      | Description     |
  |-----------|---------------|
  | VCF       | Compressed normalized VCF files |

## Contributions

  | Name      | Email | Description     |
  |-----------|---------------|-----------------|
  | Tiffany Delhomme*    | delhommet@students.iarc.fr | Developer to contact for support |
