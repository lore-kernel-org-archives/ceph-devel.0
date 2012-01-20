From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Re: [PATCH] [ceph spec] package *.py* files
Date: Fri, 20 Jan 2012 21:28:56 -0200
Message-ID: <or39baosw7.fsf@livre.localdomain>
References: <orboq2w2vq.fsf@livre.localdomain>
	<loom.20120119T183130-208@post.gmane.org>
	<orehuvp6ce.fsf@livre.localdomain>
	<20120120150342.GB7606@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:45638 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752049Ab2ATX3G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 20 Jan 2012 18:29:06 -0500
In-Reply-To: <20120120150342.GB7606@homac.suse.de> (Holger Macht's message of
	"Fri, 20 Jan 2012 16:03:42 +0100")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Holger Macht <hmacht@suse.de>
Cc: ceph-devel@vger.kernel.org

On Jan 20, 2012, Holger Macht <hmacht@suse.de> wrote:

> On Thu 19. Jan - 22:26:09, Alexandre Oliva wrote:
>> On Jan 19, 2012, Holger Macht <hmacht@suse.de> wrote:
>> 
>> > Alexandre Oliva <oliva <at> lsd.ic.unicamp.br> writes:
>> >> 
>> >> Some post-install rpmbuild defaults byte-compile all packaged python
>> >> files, so don't bother removing the .pyc files, and package .py* to
>> >> get both .pyo and .pyc.  It wastes a tiny little bit of space, but it
>> >> makes the spec file portable across a wider range of rpm and python
>> >> configurations.
>> 
>> > Just wondering...do you have a concrete issue or an example where this is a 
>> > problem?
>> 
>> It failed to build on a BLAGified Fedora 16, complaining about the
>> unpackaged .pyc files.  It's not just CentOS that creates the .pyc files
>> in brp-python-bytecompile.  

> So the built failed because *.pyo was there and *.pyc wasn't?

No, both were there, but the .pyc was (correctly) flagged as not
packaged.

> So maybe we should just always put pyc files in for maximum
> compatibility across distributions?

Yeah.

> Otherwise, if this really makes the build fail for some distributions,

The CentOS-only .pyc packaging did not cover other distros that required
it, such as Fedora and BLAG, yes.

>> Plus, they should be packaged (if at all) in python-ceph, but
>> definitely not in the main ceph package.

> They are packaged in python-ceph.

No, look at the patch.  The ugly work-around to package .pyc files on
CentOS only was not in python-ceph.

> My fault. I also recompressed them at the very start of working on the
> spec file and changed it accordingly, but I'm fine for changing this
> back to .gz.

I'd rather use the smallest available tarball, but we should use
whatever ceph publishes.  If it's going to be .gz from now on, we have
to change the spec file.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
