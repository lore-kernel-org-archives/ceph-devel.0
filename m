From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: libcephfs: Open-By-Handle API question
Date: Tue, 4 Jun 2013 09:10:52 -0400 (EDT)
Message-ID: <517089160.22.1370351451984.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <1627438937.20.1370351416076.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1259 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416Ab3FDNK7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Jun 2013 09:10:59 -0400
In-Reply-To: <1627438937.20.1370351416076.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Storozhilov <Ilya_Storozhilov@epam.com>
Cc: ceph-devel@vger.kernel.org

Hi Ilya,

The changes on this branch originated in our Ganesha NFS driver for
Ceph, so I'm not sure where the gap is, if any.

I'll send an update to the list when we've finish re-integrating against
the libcephfs-wip merge branch.

Matt

----- "Ilya Storozhilov" <Ilya_Storozhilov@epam.com> wrote:

> Hi Ceph developers,
> 
> in order to represent NFS-frontend to CephFS data storage we are
> trying to use innovative Open-By-Handle API from
> 'src/include/cephfs/libcephfs.h' file, which is of 'wip-libcephfs'
> branch at the moment. API looks quite consistent and useful but we
> couldn't find a method to get a pointer to root inode of the mounted
> Ceph filesystem.
> 
> At the moment we have found only one place, where it could be fetched
> from: an 'Inode* root' member from the 'Client' class
> ('src/client/Client.h') but it is in 'protected' section, so some hack
> is needed (e.g. to introduce a Client's descendant, which is providing
> a method to acces this protected member). Do you know, how to fetch a
> pointer to the root inode of the mounted Ceph filesystem without any
> hacking (using just an official CephFS API only)?
> 
> Thank you and best wishes,
> Ilya V. Storozhilov
> EPAM Systems
> Lead Software Engineer
> 
> P.S. What do you think about to make 'Open-By-Handle' API to be a
> primary and not low-level API to CephFS and to make POSIX-like API to
> be just a helper addendum to it?--
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

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
