From: Jimmy Tang <jtang-TdlRit5Z4I6YFDSwBDOiMg@public.gmane.org>
Subject: Re: CephFS First product release discussion
Date: Thu, 7 Mar 2013 11:54:18 +0000
Message-ID: <9A1F6C23-8038-4B30-9F93-092705D0341F@tchpc.tcd.ie>
References: <sfid-H20130305-170326-+024.05-1@marduk.tchpc.tcd.ie>
	<E0B1337A572647BA9FCC0CE8CA946F42@inktank.com>
	(sfid-H20130305-170326-+024.05-1@marduk.tchpc.tcd.ie)
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <E0B1337A572647BA9FCC0CE8CA946F42-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
	(sfid-H20130305-170326-+024.05-1-aYQRfOFZGx6hJkLm+/6EQDeXD3sScBsC@public.gmane.org)
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Greg Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


On 5 Mar 2013, at 17:03, Greg Farnum wrote:

> This is a companion discussion to the blog post at http://ceph.com/dev-no=
tes/cephfs-mds-status-discussion/ =97 go read that!
> =

> The short and slightly alternate version: I spent most of about two weeks=
 working on bugs related to snapshots in the MDS, and we started realizing =
that we could probably do our first supported release of CephFS and the rel=
ated infrastructure much sooner if we didn't need to support all of the whi=
zbang features. (This isn't to say that the base feature set is stable now,=
 but it's much closer than when you turn on some of the other things.) I'd =
like to get feedback from you in the community on what minimum supported fe=
ature set would prompt or allow you to start using CephFS in real environme=
nts =97 not what you'd *like* to see, but what you *need* to see. This will=
 allow us at Inktank to prioritize more effectively and hopefully get out a=
 supported release much more quickly! :)
> =

> The current proposed feature set is basically what's left over after we'v=
e trimmed off everything we can think to split off, but if any of the propo=
sed included features are also particularly important or don't matter, be s=
ure to mention them (NFS export in particular =97 it works right now but is=
n't in great shape due to NFS filehandle caching).
> =


fsck would be desirable, even if its just something that tells me that some=
thing is 'corrupted' or 'dangling' would be useful. quotas on sub-tree's li=
ke how the du feature is currently implemented would be nice. =


some sort of a smarter exporting of sub-tree's that would nice too e.g. if =
i mounted /ceph/fileset_1 as /myfs1 on a client, I'd like the /myfs1 to rep=
ort 100gb when i run df instead of 100tb which is the entire system that /c=
eph/ has, we're currently using rbd's here to limit what the users should h=
ave so we can present a subset of the storage managed by ceph to end users =
so they don't get excited with seeing 100tb available in cephfs (the number=
s here are fictional). managing one cephfs is probably easier than managing=
 lots of rbd's in certain cases.

Regards,
Jimmy Tang

--
Senior Software Engineer, Digital Repository of Ireland (DRI)
High Performance & Research Computing, IS Services
Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
http://www.tchpc.tcd.ie/ | jtang-TdlRit5Z4I6YFDSwBDOiMg@public.gmane.org
Tel: +353-1-896-3847
