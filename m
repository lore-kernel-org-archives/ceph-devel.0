From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: cmds crash
Date: Fri, 7 Jan 2011 13:42:44 +0800
Message-ID: <1294378964.1915.1.camel@cephhost>
References: <AANLkTimqt5_6bWaLkPZ1FicyGL=yp6VNEKuL0e7X7rAD@mail.gmail.com>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:57750 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751808Ab1AGFm1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Jan 2011 00:42:27 -0500
In-Reply-To: <AANLkTimqt5_6bWaLkPZ1FicyGL=yp6VNEKuL0e7X7rAD@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ravi Pinjala <pstatic@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi ,
you can update it as a bug to

http://tracker.newdream.net/projects/ceph


Jeff. C.P.Wu

=E5=9C=A8 2011-01-07=E4=BA=94=E7=9A=84 13:35 +0800=EF=BC=8CRavi Pinjala=
=E5=86=99=E9=81=93=EF=BC=9A
> I just upgraded to Ceph 0.24, and when I started up the cluster I got
> this crash.
>=20
> 2011-01-06 21:23:48.744864 b6855b70 mds0.cache creating system inode
> with ino:601
> 2011-01-06 21:23:48.745488 b6855b70 log [ERR] : unmatched fragstat
> size on single dirfrag 100, inode has f(v0 m2011-01-06 21:23:48.74506=
3
> 1=3D0+1), dirfrag has f(v0 m2011-01-06 21:23:48.745063 3=3D1+2)
> 2011-01-06 21:23:49.293433 b6855b70  bad get [inode 600 [...2,head]
> ~mds0/stray/ auth v26003 f(v8833 m2011-01-04 21:50:03.135177
> 8846=3D8435+411) n(v11792 rc2011-01-04 21:50:03.135177 b25052311635 a=
-18
> 8846=3D8435+411) (inest lock dirty) (ifile lock dirty) (iversion lock=
) |
> dirtyscattered dirfrag stray dirty 0x11102a68] by 19 stray was 5
> (-1005,-1005,-1,19,1001)
> mds/CInode.h: In function 'virtual void CInode::bad_get(int)':
> mds/CInode.h:1088: FAILED assert(ref_set.count(by) =3D=3D 0)
>  ceph version 0.24 (commit:180a4176035521940390f4ce24ee3eb7aa290632)
>  1: (CInode::bad_put(int)+0) [0x827b090]
>  2: (MDSCacheObject::get(int)+0x153) [0x813e463]
>  3: (MDCache::populate_mydir()+0x8a) [0x81a7e5a]
>  4: (MDCache::_create_system_file_finish(Mutation*, CDentry*,
> Context*)+0x181) [0x819f501]
>  5: (C_MDC_CreateSystemFile::finish(int)+0x29) [0x81d6c29]
>  6: (finish_contexts(std::list<Context*, std::allocator<Context*> >&,
> int)+0x6b) [0x81d663b]
>  7: (Journaler::_finish_flush(int, long long, utime_t, bool)+0x983) [=
0x82f2f53]
>  8: (Journaler::C_Flush::finish(int)+0x3f) [0x82fb24f]
>  9: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0x801) [0x82d8e31]
>  10: (MDS::_dispatch(Message*)+0x2ae5) [0x80eaa15]
>  11: (MDS::ms_dispatch(Message*)+0x62) [0x80eb142]
>  12: (SimpleMessenger::dispatch_entry()+0x899) [0x80b8649]
>  13: (SimpleMessenger::DispatchThread::entry()+0x22) [0x80b30f2]
>  14: (Thread::_entry_func(void*)+0x11) [0x80c9101]
>  15: (()+0x5cc9) [0x6ffcc9]
>  16: (clone()+0x5e) [0x7e669e]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>=20
> (The objdump it mentions is attached.)
>=20
> Anybody seen this before?
>=20
> --Ravi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
