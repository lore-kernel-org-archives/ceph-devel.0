From: "Snider, Tim" <Tim.Snider@netapp.com>
Subject: Unused doc/images/.jpg files
Date: Mon, 19 Nov 2012 22:41:15 +0000
Message-ID: <DC700C5A3AE74041B17F41EE35500AB90C899709@SACEXCMBX03-PRD.hq.netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.netapp.com ([216.240.18.37]:8134 "EHLO mx2.netapp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab2KSWlV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 17:41:21 -0500
Received: from vmwexceht04-prd.hq.netapp.com (vmwexceht04-prd.hq.netapp.com [10.106.77.34])
	by smtp1.corp.netapp.com (8.13.1/8.13.1/NTAP-1.6) with ESMTP id qAJMfKWr024883
	for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 14:41:20 -0800 (PST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi  - There are several jpg files in the doc/images directory of the tarball that don't seem to be used in the html files or man pages after docs are built. 
If they are used somewhere - where is that & what am I missing?
Some of the .png files are used.

root@84Server:~/ceph-ceph-fd4b839# ls doc/images/
AccessMethods.jpg  RADOS.jpg         chef.png              lightstack.png  radosStack.svg  techstack.png
CEPHConfig.jpg     RBD.jpg           chef.svg              lightstack.svg  stack.png       techstack.svg
CRUSH.jpg          RDBSnapshots.jpg  docreviewprocess.jpg  osdStack.svg    stack.svg

Server:~/ceph-ceph-fd4b839# grep -R osdStack.svg *
Server:~/ceph-ceph-fd4b839# grep -R techstack.png *
doc/images/techstack.svg:   inkscape:export-filename="/home/johnw/ceph/doc/images/techstack.png"
doc/images/radosStack.svg:   inkscape:export-filename="/home/johnw/ceph/doc/images/techstack.png"

Server:~/ceph-ceph-fd4b839# grep -R stack.png *
Binary file build-doc/doctrees/index.doctree matches
Binary file build-doc/doctrees/environment.pickle matches
build-doc/output/html/index.html:<img alt="_images/stack.png" src="_images/stack.png" />
build-doc/output/html/_sources/index.txt:.. image:: images/stack.png
doc/index.rst:.. image:: images/stack.png
doc/images/techstack.svg:   inkscape:export-filename="/home/johnw/ceph/doc/images/techstack.png"
doc/images/radosStack.svg:   inkscape:export-filename="/home/johnw/ceph/doc/images/techstack.png"
doc/images/stack.svg:   inkscape:export-filename="/home/johnw/ceph/doc/images/stack.png"
doc/images/lightstack.svg:   inkscape:export-filename="/home/johnw/ceph/doc/images/lightstack.png"

/tmp/ceph-ceph-fd4b839
Server:~/ceph-ceph-fd4b839# find . -name "*.jpg" -print
./doc/images/RADOS.jpg
./doc/images/CRUSH.jpg
./doc/images/AccessMethods.jpg
./doc/images/docreviewprocess.jpg
./doc/images/CEPHConfig.jpg
./doc/images/RDBSnapshots.jpg
./doc/images/RBD.jpg

Server:~/ceph-ceph-fd4b839# grep -R AccessMethods *
Server:~/ceph-ceph-fd4b839# grep -R CEPHConfig.jpg *
Server:~/ceph-ceph-fd4b839# grep -R RBD.jpg *
Server:~/ceph-ceph-fd4b839# grep -R RADOS.jpg *

Thanks,
Tim
