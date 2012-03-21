From: Alex Elder <elder@dreamhost.com>
Subject: Kernel Crash Dumps
Date: Wed, 21 Mar 2012 16:09:11 -0500
Message-ID: <4F6A4377.6020908@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:36101 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab2CUVJF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 17:09:05 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id D2F27243EF
	for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 14:10:15 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 88CD2243BE
	for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 14:10:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've been working on getting kernel crash dumps to be generated and
saved to a remote server system for later analysis.  I have managed
to wade through the maze of old, new, and conflicting information
out there and have come up with a mechanism that reliably saves a
kernel core dump in the event of a crash.  I have also written an
init script and accompanying shell script that takes a processed
crash dump and re-packages it along with supplementary information,
then copies that entire result to a remote server machine.

I did all my development work on a local machine I have physical
access to.  I have begun the process of doing the same things on
QA systems but have bumped into some obstacles.  Tv suggested
I document what I've got and post it here for others to see, and
so he (or others) might be able to help a bit.

So the following documents the process I was trying to get through
when moving my work from my home machine to one of the plana systems.

For the short term this stuff is on hold while I tend to a few other
pressing issues, but I'd like to get this stuff going soon; kernel
core dumps are an important resource for tracking down the cause of
bugs in kernel code.

					-Alex

-----------------

First, here's an overview of how it works:
- kdump init script arranges for saving and processing a kernel core
   dump at boot time:
     - loads a crashkernel (using kexec) into reserved memory, which
       will be jumped to in the event of a crash and whose sole
       purpose is to save kernel memory to disk
     - runs /usr/share/apport/kernel_crashdump to process a crash
       dump file, leaving the result in a single file in /var/crash.
- ceph-kdump-copy init script runs immediately thereafter,
   processing each file found in /var/crash that appears to have
   been created by the kdump init script, and for each, runs
   /usr/bin/ceph-kdump-copy on it to re-package and copy it to a
   designated remote host.  Here's what that script does:
     - unpacks the processed file into its constituent parts
     - collects summary information into a file "summary.txt"
     - renames the core file to be "vmcore-<kversion>" reflecting
       the kernel version
     - gathers the appropriate debug symbol file corresponding to
       the crashed kernel, along with the kernel configuration,
       system map, and other files that provide context about the
       crashed system.
     - Generates a short README file telling how to use "crash" on
       the collected files to debug the crash.
     - groups all of these files into a directory named with a date
       stamp based on the time they were collected.
     - copies the date-stamped directory to the remote server, under
       a subdirectory that contains all saved crashes from the
       crashed host.
     - removes all remnants of the crash once copying to the remote
       host is complete.

Getting all this to work together has been some trouble though,
and there are existing bugs that are worked around in the steps
described below.

================================================

First, setting up the dump server is pretty straightforward.
By default crashes are saved to /var/crash/remote on the server.
You need to arrange for the crashing hosts to have write access
using "scp" to that directory on the server, so you need to set
up ssh keys accordingly.  (I'm not going to describe that process
here.)

First, set up the directory to receive the dumps on the server:
	sudo bash <<!
	mkdir -p /var/crash/remote
	chown ubuntu.ubuntu /var/crash/remote
	!
I use the ubuntu user and group because those are already set
up with ssh keys in our test environment.

Next, install the "crash" package so we can analyze crashes:
	sudo apt-get install crash

That's really about it.

-----------------

Over to the client machine(s).

We need to have in place a kernel that has debug symbols
available.  For now, let's update to run this kernel:
	'Ubuntu, with Linux 3.0.0-16-server'
We will also need to install the debug symbols for the kernel.
(Still need to figure out how to generate these for our own custom
kernels.)
       sudo apt-get install linux-image-3.0.0-16-server
       sudo apt-get install linux-image-3.0.0-16-server-dbgsym

==> I'm having trouble figuring out where to get the dbgsym
     packages.  They sort of magically showed up when I was setting
     this up on my home system.

     To boot that I made /etc/grub.d/01_ceph_kernel look like this:
	cat <<EOF
	set default="Ubuntu, with Linux 3.0.0-16-server"
	EOF
     And then:
	sudo update-grub
     And reboot, to get into that kernel.

     This, of course, was a kernel that was already installed on my
     machine, selected from those listed in /etc/grub/grub.cfg.  Note
     that for newer versions of grub you may need to prefix the value
     assigned above with "Previous Linux versions>", i.e.:
	cat <<EOF
	set default="Previous Linux versions>Ubuntu, with Linux 3.0.0-16-server"
	EOF

Next, install linux-crashdump, which also installs several other
needed packages;
	sudo apt-get install linux-crashdump

I'm not sure at this point whether it's already installed, but it
might be useful (though not necessary) to have "crash" installed
on these machines also:
	sudo apt-get install crash

Next, we need to install the static version of makedumpfile, and
use it to replace the dynamically-linked version found in /usr/bin.
I believe that we need to update the initramdisks so they use the
statically-linked version too.
     Do this:
	sudo bash <<-!
	apt-get install makedumpfile-static
	mv /usr/bin/makedumpfile /usr/bin/makedumpfile-dynamic
	cp -a /bin/makedumpfile-static /usr/bin/makedumpfile
         update-initramfs -k all -u
	!

Next we need to make sure sufficient memory is allocated for the
crash kernel.
     Edit /etc/grub.d/10_linux:
	sudo vi /etc/grub.d/10_linux
     And make this change:
old: GRUB_CMDLINE_EXTRA="$GRUB_CMDLINE_EXTRA 
crashkernel=384M-2G:64M,2G-:128M"
new: GRUB_CMDLINE_EXTRA="$GRUB_CMDLINE_EXTRA 
crashkernel=384M-2G:128M,2G-:256M"

     And then:
	sudo update-grub

Now we need to install the new ceph-kdump-copy stuff.  There are
three files.  I started working on the packing stuff in the ceph
tree for getting them installed using apt-get install, but I barely
know what I'm doing there, so...

     We need these three files installed:
     	/usr/bin/ceph-kdump-copy
     	/etc/init.d/ceph-kdump-copy
     	/etc/default/ceph-kdump-copy

     These files are sitting here (respectively) in the ceph.git
     tree, in the branch wip-ceph-kdump-copy:
	src/ceph-kdump-copy.in
	debian/ceph-kdump-copy.init
	debian/ceph-kdump-copy.default

     Once installed, make sure these are executable:
	chmod 755 /etc/init.d/ceph-kdump-copy
	chmod 755 /usr/bin/ceph-kdump-copy

     When those are in place, we need to assign the username and host
     to which dumps will be copied, and we need to activate the init
     script.
	sudo vi /etc/default/ceph-kdump-copy
	    --> define reasonable values for KDUMP_HOST and KDUMP_HOST_USER
     	sudo update-rc.d ceph-kdump-copy start 02 2 .

     We need to have a vmcoreinfo file in place that matches the
     currently-running kernel.  I'm not sure where that comes from,
     but it may be generated automatically by the crash dump process.
==> Not sure about this.
     	
My machine at home had a separate /boot partition, and that ended up
requiring some additional commands to ensure /boot on the underlying
root filesystem was up-to-date.  The plana systems don't have a
separate boot partition so for now I'm going to repeat those
instructions here.

That's all I have (and at this point have not completed the process
of moving this over to our QA systems so I have missed something).

If a crash occurs, the whole sequence described earlier will ensue.

If you wish to trigger a crash manually, do this (as root):

     echo c > /proc/sysrq-trigger

I always preceded that command with a bunch of sync calls in order
to try to keep my filesystems intact.

================================================
