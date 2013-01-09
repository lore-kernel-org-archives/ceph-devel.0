From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: Windows port
Date: Wed, 9 Jan 2013 15:15:43 -0500 (EST)
Message-ID: <1389151709.57.1357762543179.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <394529720.47.1357762096467.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1534 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932488Ab3AIUPw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 9 Jan 2013 15:15:52 -0500
In-Reply-To: <394529720.47.1357762096467.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Dino Yancey <dino2gnt@gmail.com>, Cesar Mello <cmello@gmail.com>, ceph-devel@vger.kernel.org, Florian Haas <florian@hastexo.com>, peter honeyman <peter.honeyman@gmail.com>

Hi,

Along the same lines, (p)NFS access from Windows clients should already be possible, for some definition of possible.  We'll make it actually possible over the next few months.  

Matt

----- "Sage Weil" <sage@inktank.com> wrote:

> On Wed, 9 Jan 2013, Florian Haas wrote:
> > On Tue, Jan 8, 2013 at 3:00 PM, Dino Yancey <dino2gnt@gmail.com>
> wrote:
> > > Hi,
> > >
> > > I am also curious if a Windows port, specifically the client-side,
> is
> > > on the roadmap.
> > 
> > This is somewhat OT from the original post, but if all you're
> > interested is using RBD block storage from Windows, you can already
> do
> > that by going through an iSCSI or FC head node. Proof-of-concept
> > configuration outlined here:
> > 
> >
> http://www.hastexo.com/resources/hints-and-kinks/turning-ceph-rbd-images-san-storage-devices
> > 
> > Not sure if this helps, but just thought I'd mention it.
> 
> There is also a patch for Samba that glues libcephfs into Samba's VFS
> 
> layer.  This will let you reexport CephFS via CIFS.  These patches are
> 
> currently living at
> 
> 	https://github.com/ceph/samba/commits/ceph-v3-6-test
> 
> If anybody is interested in playing with these, have at it!  Inktank 
> doesn't have resources to focus on it right now.
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel. 734-761-4689
fax. 734-769-8938
cel. 734-216-5309
