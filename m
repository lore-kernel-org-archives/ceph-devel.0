From: Sam Just <sam.just@inktank.com>
Subject: Re: domino-style OSD crash
Date: Mon, 4 Jun 2012 10:40:58 -0700
Message-ID: <CA+4uBUYoDFWcYhmd_EacQgJSf+i=WcA7x-PNWZ0EerD+_fTAjg@mail.gmail.com>
References: <4FCC7573.3000704@univ-nantes.fr>
	<CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44304 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab2FDRk7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 13:40:59 -0400
Received: by pbbrp8 with SMTP id rp8so6287292pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jun 2012 10:40:58 -0700 (PDT)
In-Reply-To: <CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Yann Dupont <Yann.Dupont@univ-nantes.fr>, ceph-devel <ceph-devel@vger.kernel.org>

Can you send the osd logs?  The merge_log crashes are probably fixable
if I can see the logs.

The leveldb crash is almost certainly a result of memory corruption.

Thanks
-Sam

On Mon, Jun 4, 2012 at 9:16 AM, Tommi Virtanen <tv@inktank.com> wrote:
> On Mon, Jun 4, 2012 at 1:44 AM, Yann Dupont <Yann.Dupont@univ-nantes.=
fr> wrote:
>> Results : Worked like a charm during two days, apart btrfs warn mess=
ages
>> then OSD begin to crash 1 after all 'domino style'.
>
> Sorry to hear that. Reading through your message, there seem to be
> several problems; whether they are because of the same root cause, I
> can't tell.
>
> Quick triage to benefit the other devs:
>
> #1: kernel crash, no details available
>> 1 of the physical machine was in kernel oops state - Nothing was rem=
ote
>
> #2: leveldb corruption? may be memory corruption that started
> elsewhere.. Sam, does this look like the leveldb issue you saw?
>> =A0[push] v 1438'9416 snapset=3D0=3D[]:[] snapc=3D0=3D[]) v6 current=
ly started
>> =A0 =A0 0> 2012-06-03 12:55:33.088034 7ff1237f6700 -1 *** Caught sig=
nal
>> (Aborted) **
> ...
>> =A013: (leveldb::InternalKeyComparator::FindShortestSeparator(std::s=
tring*,
>> leveldb::Slice const&) const+0x4d) [0x6ef69d]
>> =A014: (leveldb::TableBuilder::Add(leveldb::Slice const&, leveldb::S=
lice
>> const&)+0x9f) [0x6fdd9f]
>
> #3: PG::merge_log assertion while recovering from the above; Sam, any=
 ideas?
>> =A0 =A0 0> 2012-06-03 13:36:48.147020 7f74f58b6700 -1 osd/PG.cc: In =
function
>> 'void PG::merge_log(ObjectStore::Transaction&, pg_info_t&, pg_log_t&=
, int)'
>> thread 7f74f58b6700 time 2012-06-03 13:36:48.100157
>> osd/PG.cc: 402: FAILED assert(log.head >=3D olog.tail && olog.head >=
=3D
>> log.tail)
>
> #4: unknown btrfs warnings, there should an actual message above this
> traceback; believed fixed in latest kernel
>> Jun =A02 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479=
278]
>> [<ffffffffa026fca5>] ? btrfs_orphan_commit_root+0x105/0x110 [btrfs]
>> Jun =A02 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479=
328]
>> [<ffffffffa026965a>] ? commit_fs_roots.isra.22+0xaa/0x170 [btrfs]
>> Jun =A02 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479=
379]
>> [<ffffffffa02bc9a0>] ? btrfs_scrub_pause+0xf0/0x100 [btrfs]
>> Jun =A02 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479=
415]
>> [<ffffffffa026a6f1>] ? btrfs_commit_transaction+0x521/0x9d0 [btrfs]
>> Jun =A02 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479=
460]
>> [<ffffffff8105a9f0>] ? add_wait_queue+0x60/0x60
>> Jun =A02 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479=
493]
>> [<ffffffffa026aba0>] ? btrfs_commit_transaction+0x9d0/0x9d0 [btrfs]
>> Jun =A02 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479=
543]
>> [<ffffffffa026abb1>] ? do_async_commit+0x11/0x20 [btrfs]
>> Jun =A02 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479=
572]
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
