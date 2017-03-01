#!/usr/bin/env cwl-runner
#
# Author: Jeltje van Baren jeltje.van.baren@gmail.com

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [/opt/bin/muse.py, -O, muse.vcf, -w, ./, --muse, MuSEv1.0rc]

doc: "Runs MuSEv1.0rc SNP caller on split chromosomes (MuSE call) then creates final calls in VCF format (MuSE sump)"

hints:
  DockerRequirement:
    dockerPull: quay.io/opengenomics/muse

#requirements:
#  - class: InlineJavascriptRequirement

inputs:
  tumor:
    type: File
    doc: |
      tumor bam file
    inputBinding:
      prefix: --tumor-bam
    secondaryFiles:
      - .bai
  normal:
    type: File
    doc: |
      normal bam file
    inputBinding:
      prefix: --normal-bam
    secondaryFiles:
      - .bai
  reference:
    type: File
    doc: |
     Reference sequence file, can be gzipped.
    inputBinding:
      prefix: -f
  known:
    type: File
    doc: |
      dbSNP vcf file (will be bgzip compressed and tabix indexed). Can be gzipped.
    inputBinding:
      prefix: -D
  mode:
    type: {"type": "enum", "name": "Mode", "symbols": ["wgs", "wxs"]}
    doc: |
      Input is whole genome or exome {wgs,wxs}
    inputBinding:
      prefix: --mode
  ncpus:
    type: int?
    doc: |
      number of cpus (8)
    inputBinding:
      position: 2
      prefix: --cpus

outputs:
  mutations:
    type: File
    outputBinding:
      glob: muse.vcf


