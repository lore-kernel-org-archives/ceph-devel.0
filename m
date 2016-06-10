From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] Ceph updates for 4.7-rc1
Date: Fri, 10 Jun 2016 22:42:51 +0200
Message-ID: <3724610.gtEplKGO6B@wuerfel>
References: <alpine.DEB.2.11.1605261035390.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1605261035390.6221@cpach.fuggernut.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sage Weil <sweil@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
List-Id: ceph-devel.vger.kernel.org

On Thursday, May 26, 2016 2:18:03 PM CEST Sage Weil wrote:
> Hi Linus,
> 
> Please pull the following Ceph updates from
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus
> 
> This changeset has a few main parts:
> 
>  * Ilya has finished a huge refactoring effort to sync up the client-side 
> logic in libceph with the user-space client code, which has evolved 
> significantly over the last couple years, with lots of additional 
> behaviors (e.g., how requests are handled when cluster is full and 
> transitions from full to non-full).  This structure of the code is more 
> closely aligned with userspace now such that it will be much easier to 
> maintain going forward when behavior changes take place.  There are some 
> locking improvements bundled in as well.

I'm getting a warning in some ARM randconfig build:

WARNING: "ceph_monc_do_statfs" [fs/ceph/ceph.ko] has no CRC!                                             

I have bisected this down to this particular commit fcd00b68bbe:
 
> ----------------------------------------------------------------
> Ilya Dryomov (40):
>       libceph: DEFINE_RB_FUNCS macro

but I have no idea how the change relates to the symptom though.

What I see is that this one exported symbol has a __crc of a different
type from all the others:

$ nm net/ceph/mon_client.o | grep __crc
48c2e16e A __crc_ceph_monc_get_version
2360d633 A __crc_ceph_monc_get_version_async
0c50a10a A __crc_ceph_monc_got_map
         w __crc_ceph_monc_do_statfs
b63e5cf5 A __crc_ceph_monc_init
c4602476 A __crc_ceph_monc_open_session
5e6fd15f A __crc_ceph_monc_renew_subs
53a9ed7f A __crc_ceph_monc_stop
33a329fa A __crc_ceph_monc_validate_auth
34010ef9 A __crc_ceph_monc_wait_osdmap
29c50846 A __crc_ceph_monc_want_map

I only see this in some rare randconfig builds and have not figured out
which options are required, but I have also been able to reproduce it on
an x86 config and have uploaded the .config file to 
http://pastebin.com/raw/Dsrtfbcs 

	Arnd
