From: Sage Weil <sage@newdream.net>
Subject: Re: Status of ceph ITP?
Date: Wed, 1 Dec 2010 10:15:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012011010570.29814@cobra.newdream.net>
References: <1290365977.9821.3.camel@clint-MacBookPro>
 <Pine.LNX.4.64.1011211521510.17131@cobra.newdream.net>
 <1290436452.9821.5.camel@clint-MacBookPro> <Pine.LNX.4.64.1011291120510.4337@cobra.newdream.net>
 <1291075213.14018.101.camel@julia.gcs.org.hu> <Pine.LNX.4.64.1011300922530.30759@cobra.newdream.net>
 <1291221518.14018.564.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34035 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab0LASLH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Dec 2010 13:11:07 -0500
In-Reply-To: <1291221518.14018.564.camel@julia.gcs.org.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: Clint Byrum <clint@ubuntu.com>, asheesh@asheesh.org, 506040@bugs.debian.org, noel@debian.org, ceph-devel@vger.kernel.org

Hi Laszlo,

On Wed, 1 Dec 2010, Laszlo Boszormenyi wrote:
> Hi Sage,
> 
> On Tue, 2010-11-30 at 10:21 -0800, Sage Weil wrote:
> > Great!  There are a handful of bug fixes I'd like to roll into v0.23.2 
> > first, if it isn't too much trouble.  I can do that today.
>  I've found the manpage problem that I've noted before. It's about
> monmaptool, the CLI says it's usage:
> [--print] [--create [--clobber]] [--add name 1.2.3.4:567] [--rm name] <mapfilename>
> But the manpage states this as an example:
> monmaptool --create --add 192.168.0.10:6789 --add 192.168.0.11:6789 --add 192.168.0.12:6789 --clobber monmap
> This definitely misses 'name' after the 'add' switch, resulting:
> "invalid ip:port '--add'" as an error message. Attached patch fixes this
> inconsistency.

Applied, thanks!

> > Clint, do you see any remaining issues I should fix first?
>  Just for the record, I have tested ceph on Ubuntu Maverick. It builds
> fine and upgrades from the previous version in the archive.
> Clint is lost somewhere :-( , but I think everything is OK from his side
> as well. So what if I would step in for being the packager of ceph both
> in Debian and Ubuntu? Sage can contact me before he makes a release, I
> adjust the packaging if necessary and he can roll out packages
> immediately. I recheck them and if they are OK, I make the upload to the
> archives. All I need is a commit right to the debian/ subdir in the git
> tree of ceph.

Can you take a look at the 'testing' branch in git commit 5bdae2af?  
That's how I've been doing releases, more or less.  Assuming packaging 
issues are sorted out prior to that point, that's all that should be 
needed, right?  I can also set you up with push access to update the 
debian/ stuff at your leisure without sending patches over the list.

(BTW, the v0.23.2 bugfix release is mostly pointless as v0.24 is just a 
couple days away anyway.  Just for the sake of illustration...)

sage
