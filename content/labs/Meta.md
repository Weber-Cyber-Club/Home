+++
title = "Meta"
date = "2025-10-17T22:11:04-06:00"
author = "Sahara Krompel"
cover = "/Home/assets/doomtech_banner.png"
coverCaption = ""
categories = ["OSINT"]
description = "This lab is adapted from the National Cyber League Gymnasium Open Source Intelligence easy challenge titled *Meta* The purpose of this lab is to teach students how to extract and analyze metadata from image files using both online tools and command-line utilities, while understanding the security and privacy implications of embedded metadata."
showFullContent = false
readingTime = false
hideComments = true
+++

# Meta

## Purpose:

This lab is adapted from the National Cyber League Gymnasium Open Source Intelligence easy challenge "Meta." The purpose of this lab is to teach students how to extract and analyze metadata from image files using both online tools and command-line utilities, while understanding the security and privacy implications of embedded metadata.

## Background:

### What is Metadata?

Meta- is a prefix meaning "self-referential." Therefore, metadata essentially means "data about data." This is information that describes, contextualizes, or provides details about other data. In OSINT (Open Source Intelligence) and digital forensics, metadata is a critical source of intelligence that often reveals more than the visible content itself. When you create, modify, or share a file, systems automatically embed metadata that can include usernames, software versions, GPS coordinates, timestamps, edit history, and device information.

The image metadata in this lab is stored in EXIF (Exchangeable Image File Format) format. EXIF is a standard that specifies how metadata is embedded within image and audio files. EXIF data is stored alongside the actual image pixels.

### How is Metadata Used?

#### From a Red Team/Attacker Perspective:

Metadata can be scanned to identify software vulnerabilities and reconnaissance opportunities. GPS coordinates embedded in posted photos can expose facility locations or travel patterns.

#### From a Digital Forensics/Incident Response/Blue Team Perspective:

Metadata can be used to reconstruct attack timelines by correlating file creation timestamps, last modified dates, and access logs across systems.

## Lab Guide:

![Meta.jpg](/Home/assets/meta/Meta.jpg)

This lab contains one [JPEG image file](/Home/assets/meta/Meta.jpg) featuring a baby lamb. There are two main ways to extract the metadata from this file and answer the [questions](#questions).

The first of these ways is to utilize an online tool such as https://www.metadata2go.com/.

The second of these ways is to utilize command line tools. Some tools that are most useful for the task of metadata extraction (in the case of this lab) are `file`, and `strings`, `ExifTool`.

**The `file` Command:**

`file` is a command-line utility that identifies file types and provides basic information about files. Rather than trusting file extensions (which can be changed or spoofed), file examines the actual content and structure of a file to determine what it really is.

**The `strings` Command:**

`strings` is a command-line utility that extracts readable text (printable character sequences) from binary files. While tools like ExifTool are designed specifically for structured metadata, strings takes a brute-force approach - it scans through the entire file and pulls out anything that looks like human-readable text.

**The ExifTool Command:**

ExifTool is a comprehensive metadata extraction and manipulation tool. While `file` gives you a quick preview and `strings` dumps raw text, ExifTool is purpose-built for structured metadata analysis. It can read, write, and edit the metadata of virtually every file type.

To see available options for these tools:

**ExifTool**: `exiftool -h` (both Linux and Windows)

**file**: `file --help (Linux)` or `man file` for detailed documentation

**strings**: `strings --help` (Linux)

Running `file Meta.jpg` produces the following output:

```
Meta.jpg: JPEG image data, JFIF standard 1.01, resolution (DPI), density 240x240, segment length 16, Exif Standard: [TIFF image data, little-endian, direntries=8, compression=JPEG (old), manufacturer=Apple, model=Apple iPhone 5, xresolution=132, yresolution=140, resolutionunit=2, GPS-Data], baseline, precision 8, 1024x768, components 3
```

The `file` command reveals file type, device information, image specifications. One key aspect of this output to note is the GPS-Data tag. This tag indicates that the image contains embedded geolocation coordinates. While the `file` command confirms GPS data exists, it doesn't display the actual latitude/longitude, timestamps, or other detailed EXIF fields.

Running `strings Meta.jpg` produces a mix of readable text extracted from the binary image data. While this output can be carefully sifted through to find the desired information, it is best used with a text filtering and pattern matching tool like grep (Global Regular Expression Print). By utilizing the pipe symbol, "`|`", you can take the output from the `strings` command and feed it into the `grep` command.
For example:

- `strings Meta.jpg | grep -i "gps"` - finds all lines mentioning GPS data

The `-i` flag makes the search case-insensitive.

Running `exiftool Meta.jpg` produces the following output:

```
ExifTool Version Number         : 12.76
File Name                       : Meta.jpg
Directory                       : .
File Size                       : 565 kB
File Modification Date/Time     : 2025:10:09 20:22:56-06:00
File Access Date/Time           : 2025:10:09 20:23:08-06:00
File Inode Change Date/Time     : 2025:10:09 20:22:56-06:00
File Permissions                : -rw-r--r--
File Type                       : JPEG
File Type Extension             : jpg
MIME Type                       : image/jpeg

(...)

Image Size                      : 1024x768
Megapixels                      : 0.786
Shutter Speed                   : 1/640
Thumbnail Image                 : (Binary data 9828 bytes, use -b option to extract)
GPS Latitude                    : 39 deg 52' 30.00" N
GPS Longitude                   : 20 deg 0' 36.00" E
GPS Position                    : 39 deg 52' 30.00" N, 20 deg 0' 36.00" E
```

## Questions:

1. When was the image created?
2. What are the dimensions of the image? (ex: 800x600)
3. What is the make of the camera that took the picture?
4. What is the model of the camera that took the picture?
5. What is the exposure time for the picture? (ex: 1/200)
6. What are the GPS coordinates where the was the picture taken?

## Conclusion:

In this lab, students have learned how to extract and analyze metadata from image files using both online tools and command-line utilities. By exploring tools like file, strings, grep, and exiftool, you've seen how different approaches reveal varying levels of detail—from quick file identification to comprehensive EXIF data extraction. This lab also demonstrated to you that metadata often reveals far more than intended: a simple photo of a baby lamb contained the exact location where it was taken, the specific device used, and precise timestamps.

## Answers

**The answers to the question asked within this lab are contained within the [Meta Lab Answer File](/Home/extradocs/meta/meta-answers/).**
