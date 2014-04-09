From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [Share]Performance tunning on Ceph FileStore with SSD backend
Date: Wed, 09 Apr 2014 14:08:25 +0200 (CEST)
Message-ID: <b93e6941-f0d2-4ea4-b516-23bd13d0431f@mailpro>
References: <CACJqLyb+D5n74OyjP4sRG2=G083GQ3BzEUt4i8iAdw6nEBfRJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:48592 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932866AbaDIMId convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Apr 2014 08:08:33 -0400
In-Reply-To: <CACJqLyb+D5n74OyjP4sRG2=G083GQ3BzEUt4i8iAdw6nEBfRJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

thanks for sharing !
(I'm looking to build a full ssd cluster too with 1TB ssd)

>>With these, we achieve 3x-4x performance improvements on filestore wi=
th SSD.=20

Do you have some iops values benchmark, before and after ?



----- Mail original -----=20

De: "Haomai Wang" <haomaiwang@gmail.com>=20
=C3=80: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mercredi 9 Avril 2014 12:05:19=20
Objet: [Share]Performance tunning on Ceph FileStore with SSD backend=20

Hi all,=20

I would like to share some ideas about how to improve performance on=20
ceph with SSD. Not much preciseness.=20

Our ssd is 500GB and each OSD own a SSD(journal is on the same SSD).=20
ceph version is 0.67.5(Dumping)=20

At first, we find three bottleneck on filestore:=20
1. fdcache_lock(changed in Firely release)=20
2. lfn_find in omap_* methods=20
3. DBObjectMap header=20

According to my understanding and the docs in=20
ObjectStore.h(https://github.com/ceph/ceph/blob/master/src/os/ObjectSto=
re.h),=20
I simply remove lfn_find in omap_* and fdcache_lock. I'm not fully=20
sure the correctness of this change, but it works well still now.=20

DBObjectMap header patch is on the pull request queue and may be=20
merged in the next feature merge window.=20

With things above done, we get much performance improvement in disk=20
util and benchmark results(3x-4x).=20

Next, we find fdcache size become the main bottleneck. For example, if=20
hot data range is 100GB, we need 25000(100GB/4MB) fd to cache. If hot=20
data range is 1TB, we need 250000(1000GB/4MB) fd to cache. With=20
increase "filestore_fd_cache_size", the cost of lookup(FDCache) and=20
cache miss is expensive and can't be afford. The implementation of=20
=46DCache isn't O(1). So we only can get high performance on fdcache hi=
t=20
range(maybe 100GB with 10240 fdcache size) and more data exceed the=20
size of fdcaceh will be disaster. If you want to cache more fd(102400=20
fdcache size), the implementation of FDCache will bring on extra CPU=20
cost(can't be ignore) for each op.=20

Because of the capacity of SSD(several hundreds GB), we try to=20
increase the size of rbd object(16MB) so less fd cache is needed. As=20
for FDCache implementation, we simply discard SimpleLRU but introduce=20
RandomCache. Now we can set much larger fdcache size(near cache all=20
fd) with little overload.=20

With these, we achieve 3x-4x performance improvements on filestore with=
 SSD.=20

Maybe it exists something I missed or something wrong, hope can=20
correct me. I hope it can help to improve FileStore on SSD and push=20
into master branch.=20

--=20

Best Regards,=20

Wheat=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
