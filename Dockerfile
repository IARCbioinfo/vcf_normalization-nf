################## BASE IMAGE ######################
FROM biocontainers/biocontainers:v1.0.0_cv4

################## METADATA ######################

LABEL base_image="biocontainers:v1.0.0_cv4"
LABEL version="1.0"
LABEL software="vt-nf"
LABEL software.version="1.0"
LABEL about.summary="vt normalization with nextflow"
LABEL about.home="http://github.com/IARCbioinfo/vt-nf"
LABEL about.documentation="http://github.com/IARCbioinfo/vt-nf/README.md"
LABEL about.license_file="http://github.com/IARCbioinfo/vt-nf/LICENSE.txt"
LABEL about.license="GNU-3.0"

################## MAINTAINER ######################
MAINTAINER Tiffany Delhomme <delhommet@students.iarc.fr>

################## INSTALLATION ######################

RUN conda install -c bioconda vt
RUN conda install -c bioconda tabix 
