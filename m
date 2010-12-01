From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: Re: Status of ceph ITP?
Date: Wed, 01 Dec 2010 17:38:38 +0100
Message-ID: <1291221518.14018.564.camel@julia.gcs.org.hu>
References: <1290365977.9821.3.camel@clint-MacBookPro>
	 <Pine.LNX.4.64.1011211521510.17131@cobra.newdream.net>
	 <1290436452.9821.5.camel@clint-MacBookPro>
	 <Pine.LNX.4.64.1011291120510.4337@cobra.newdream.net>
	 <1291075213.14018.101.camel@julia.gcs.org.hu>
	 <Pine.LNX.4.64.1011300922530.30759@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-bmbnX98bsDQSIJWvRWBp"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.routers.hu ([212.40.96.82]:47791 "EHLO mail.routers.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880Ab0LAQjO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 1 Dec 2010 11:39:14 -0500
In-Reply-To: <Pine.LNX.4.64.1011300922530.30759@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Clint Byrum <clint@ubuntu.com>, asheesh@asheesh.org, 506040@bugs.debian.org, noel@debian.org, ceph-devel@vger.kernel.org


--=-bmbnX98bsDQSIJWvRWBp
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi Sage,

On Tue, 2010-11-30 at 10:21 -0800, Sage Weil wrote:
> Great!  There are a handful of bug fixes I'd like to roll into v0.23.2 
> first, if it isn't too much trouble.  I can do that today.
 I've found the manpage problem that I've noted before. It's about
monmaptool, the CLI says it's usage:
[--print] [--create [--clobber]] [--add name 1.2.3.4:567] [--rm name] <mapfilename>
But the manpage states this as an example:
monmaptool --create --add 192.168.0.10:6789 --add 192.168.0.11:6789 --add 192.168.0.12:6789 --clobber monmap
This definitely misses 'name' after the 'add' switch, resulting:
"invalid ip:port '--add'" as an error message. Attached patch fixes this
inconsistency.

> Clint, do you see any remaining issues I should fix first?
 Just for the record, I have tested ceph on Ubuntu Maverick. It builds
fine and upgrades from the previous version in the archive.
Clint is lost somewhere :-( , but I think everything is OK from his side
as well. So what if I would step in for being the packager of ceph both
in Debian and Ubuntu? Sage can contact me before he makes a release, I
adjust the packaging if necessary and he can roll out packages
immediately. I recheck them and if they are OK, I make the upload to the
archives. All I need is a commit right to the debian/ subdir in the git
tree of ceph.

Regards,
Laszlo/GCS

--=-bmbnX98bsDQSIJWvRWBp
Content-Disposition: attachment; filename="monmaptool_man.patch"
Content-Type: text/x-patch; name="monmaptool_man.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

--- ./man/monmaptool.8.orig	2010-12-01 17:27:15.136967000 +0100
+++ ./man/monmaptool.8	2010-12-01 17:33:58.352967001 +0100
@@ -34,15 +34,15 @@
 \fB\-\-create\fP
 will create a new monitor map with a new UUID (and with it, a new, empty Ceph file system).
 .TP
-\fB\-\-add\fI ip:port\fP
+\fB\-\-add\fI name ip:port\fP
 will add a monitor with the specified \fIip:port\fP to the map.
 .TP
-\fB\-\-rm\fI ip:port\fP
+\fB\-\-rm\fI name\fP
 will remove the monitor with the specified \fIip:port\fP from the map.
 .SH EXAMPLE
 To create a new map with three monitors (for a fresh Ceph file system):
 .IP
-monmaptool --create --add 192.168.0.10:6789 --add 192.168.0.11:6789 --add 192.168.0.12:6789 --clobber monmap
+monmaptool --create --add mon0 192.168.0.10:6789 --add mon1 192.168.0.11:6789 --add mon2 192.168.0.12:6789 --clobber monmap
 .PP
 To display the contents of the map:
 .IP
@@ -50,7 +50,7 @@
 .PP
 To replace one monitor:
 .IP
-monmaptool --rm 192.168.0.10:6789 --add 192.168.0.9:6789 --clobber monmap
+monmaptool --rm mon0 --add mon0 192.168.0.9:6789 --clobber monmap
 .SH AVAILABILITY
 .B monmaptool
 is part of the Ceph distributed file system.  Please refer to the Ceph wiki at

--=-bmbnX98bsDQSIJWvRWBp--

