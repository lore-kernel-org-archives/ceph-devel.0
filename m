From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] Ceph updates for 4.7-rc1
Date: Sun, 12 Jun 2016 00:50:28 +0200
Message-ID: <11020328.SrhRCkShXx@wuerfel>
References: <alpine.DEB.2.11.1605261035390.6221@cpach.fuggernut.com> <3724610.gtEplKGO6B@wuerfel> <CA+55aFxOZSKjePXaCrB=WDdEr1kxXMCEwonfBODbmk=9x-p0CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFxOZSKjePXaCrB=WDdEr1kxXMCEwonfBODbmk=9x-p0CA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sage Weil <sweil@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Michal Marek <mmarek@suse.cz>, Sam Ravnborg <sam@ravnborg.org>
List-Id: ceph-devel.vger.kernel.org

On Friday, June 10, 2016 2:32:21 PM CEST Linus Torvalds wrote:
> On Fri, Jun 10, 2016 at 1:42 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > What I see is that this one exported symbol has a __crc of a different
> > type from all the others:
> >
> > $ nm net/ceph/mon_client.o | grep __crc
> > 48c2e16e A __crc_ceph_monc_get_version
> > 2360d633 A __crc_ceph_monc_get_version_async
> > 0c50a10a A __crc_ceph_monc_got_map
> >          w __crc_ceph_monc_do_statfs
> 
> A lower-case 'w' in a symbol list just means that it's a local weak
> symbol (with a upper-case 'A' meaning it's an absolute global).
> 
> Afaik, that simply means that it never got resolved, and genksyms
> never generated that absolute value for it.
> 
> As to _why_ that happens, that's more than I can guess. We've had
> problems with genksyms before, and it tends to be hard to debug.

(Cc: Michal and Sam, who might understand this better)

I still don't know what goes wrong, but the patch below fixes it.
I have experimentally determined that the next EXPORT_SYMBOL() after
the DEFINE_RB_FUNCS line in net/ceph/mon_client.c ends up without
a checksum, and that adding a semicolon at the end of that line
makes it work fine.

However, there are other DEFINE_RB_FUNCS instances in
net/ceph/osd_client.c that don't suffer from this problem,
so I still have no clue why it helps, and we probably don't
want to apply the patch unless we know what the problem is.

	Arnd

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 37c38a7fb5c5..1ac468920495 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -478,7 +478,7 @@ out:
 /*
  * generic requests (currently statfs, mon_get_version)
  */
-DEFINE_RB_FUNCS(generic_request, struct ceph_mon_generic_request, tid, node)
+DEFINE_RB_FUNCS(generic_request, struct ceph_mon_generic_request, tid, node);
 
 static void release_generic_request(struct kref *kref)
 {
