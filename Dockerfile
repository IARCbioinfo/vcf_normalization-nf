################## BASE IMAGE ######################
FROM nfcore/base

################## METADATA ######################

LABEL base_image="nfcore/base"
LABEL version="1.0"
LABEL software="vcf_normalization-nf"
LABEL software.version="1.0"
LABEL about.summary="vcf normalization with nextflow"
LABEL about.home="http://github.com/IARCbioinfo/vcf_normalization-nf"
LABEL about.documentation="http://github.com/IARCbioinfo/vcf_normalization-nf/README.md"
LABEL about.license_file="http://github.com/IARCbioinfo/vcf_normalization-nf/LICENSE.txt"
LABEL about.license="GNU-3.0"

################## MAINTAINER ######################
MAINTAINER Nicolas Alcala <alcalan@fellows.iarc.fr>

################## INSTALLATION ######################

COPY environment.yml /
RUN conda env update -n root -f /environment.yml && conda clean -a
