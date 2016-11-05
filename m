From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: debug coredump on teuthology
Date: Sat, 5 Nov 2016 17:24:47 +1000
Message-ID: <20161105072447.GH6273@rskikr.localdomain>
References: <CAJE9aOOy503R8HAjhqOKA0RCfZA9y67h0JQfFzcXaFSZr6Fs5g@mail.gmail.com>
 <CAN=+7FUqx5frgb7JZFveeey8umV+_CLfs971Mh3fCwdTHsutmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34907 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbcKEHY4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Nov 2016 03:24:56 -0400
Received: by mail-pf0-f180.google.com with SMTP id i88so63774874pfk.2
        for <ceph-devel@vger.kernel.org>; Sat, 05 Nov 2016 00:24:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAN=+7FUqx5frgb7JZFveeey8umV+_CLfs971Mh3fCwdTHsutmw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Kefu Chai <tchaikov@gmail.com>, Samuel Just <sjust@redhat.com>, Sage Weil <sweil@redhat.com>


On Sat, Nov 5, 2016 at 12:26 AM, Samuel Just <sjust@redhat.com> wrote:
> Cool!

Indeed, nice work Kefu.

I would like to take this opportunity to add some notes and caveats :)

The procedure I shared, and therefore Kefu's script, *can* work well and save
considerable amount of time however you will want to be aware of some facts and
double-check that what you are seeing is accurate before relying on it too
heavily.

Since we are only downloading the binary involved and its debuginfo you may, or
may not, get a usable backtrace when you bring up your gdb session. The reason
for this is that if the frames of the backtrace are resolvable within the binary
and/or debuginfo provided you should get a decent backtrace, if they are not
then you may get nothing, lots of '?'s, or rubbish.

Why would the frame not be resolvable?

The frame may represent a function which is not in the binary that crashed and
therefore not resolvable (for example it may be in a dso, libc, libgcc,
libtcmalloc, etc.)

So what to do in such a situation?

I'll stick to rpm based systems, since I'm still working on how to identify a
package from its buildid under deb based systems.

If you have a list of the packages installed on the host that produced the
coredump you can just download them and extract them in the local directory and
you should eventually get a full backtrace if all goes well. If you need to
identify the packages required here's an approach.

Find the buildids from the coredump.

$ eu-unstrip -n --core ./1477613184.29410.core
0x7f5741f53000+0x222000 15aed4855920e5a0fb8791b683eb88c7e1199260@0x7f5741f531d8 - - /lib/x86_64-linux-gnu/liblzma.so.5.0.0
0x7f5742175000+0x204000 1c49b39b2c476cce4d64c985c8c6829a2ce60146@0x7f57421751d8 - - /usr/lib/x86_64-linux-gnu/libplds4.so
0x7f5742379000+0x205000 520a0b74241f21c49a10c7012a9088977654faea@0x7f57423791d8 - - /usr/lib/x86_64-linux-gnu/libplc4.so
0x7f574257e000+0x22c000 e2fa750a304dcaca39c9275cd63ea04aff3a21c8@0x7f574257e1d8 - - /usr/lib/x86_64-linux-gnu/libnssutil3.so
0x7f57427aa000+0x210000 e1031ddbffe20367e874b7093eec0c8d9f3b43f6@0x7f57427aa1d8 - - /lib/x86_64-linux-gnu/libbz2.so.1.0.4
0x7f57429ba000+0x219000 7ee9bc42787a0f9a793bdbfcb0671fd12c52bc2a@0x7f57429ba1d8 - - /lib/x86_64-linux-gnu/libz.so.1.2.8
0x7f5742bd3000+0x206000 5ad278db2b1442d92890e2bf739ae9e2a4334e14@0x7f5742bd31d8 - - /usr/lib/libsnappy.so.1.1.4
0x7f5742dd9000+0x21b000 11e7491ee391903dee471d098dd64a94d4f3553f@0x7f5742dd9210 - - /usr/lib/x86_64-linux-gnu/libunwind.so.8.0.1
0x7f5742ff4000+0x3c5000 cf699a15caae64f50311fc4655b86dc39a479789@0x7f5742ff4280 - - /lib/x86_64-linux-gnu/libc-2.19.so
0x7f57433b9000+0x216000 36311b4457710ae5578c4bf00791ded7359dbb92@0x7f57433b91a0 - - /lib/x86_64-linux-gnu/libgcc_s.so.1
0x7f57435cf000+0x306000 d144258e614900b255a31f3fd2283a878670d5bc@0x7f57435cf248 - - /lib/x86_64-linux-gnu/libm-2.19.so
0x7f57438d5000+0x304000 76190e922af7457d078f75c9b15fa184e83eb506@0x7f57438d5210 - - /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.19
0x7f5743bd9000+0x23d000 db50880ae5e0a37475fbeae724838f17fc2506b9@0x7f5743bd91d8 - - /usr/lib/x86_64-linux-gnu/libnspr4.so
0x7f5743e16000+0x33c000 d963167f8b7f289a0d6c1eee3961573154a02e9e@0x7f5743e161d8 - - /usr/lib/x86_64-linux-gnu/libnss3.so
0x7f5744152000+0x21e000 31e9f21ae8c10396171f1e13da15780986fa696c@0x7f5744152248 - - /lib/x86_64-linux-gnu/libpthread-2.19.so
0x7f5744370000+0x219000 97fe266a233f38fc06da11d70a98d905ebaf4d0c@0x7f57443701d8 - - /usr/lib/x86_64-linux-gnu/libboost_iostreams.so.1.54.0
0x7f5744589000+0x203000 41ad63d05b8787d608a68db9ff998ce58396718a@0x7f57445891d8 - - /usr/lib/x86_64-linux-gnu/libboost_random.so.1.54.0
0x7f574478c000+0x204000 b2cbdc11873cd013c5590773223d50d36b141041@0x7f574478c1d8 - - /usr/lib/x86_64-linux-gnu/libboost_system.so.1.54.0
0x7f5744990000+0x216000 026cddcc8e96b9e4cf0aeba1f9133d65fe32b16d@0x7f57449901d8 - - /usr/lib/x86_64-linux-gnu/libboost_thread.so.1.54.0
0x7f5744ba6000+0x24d000 dea662096bd6de078c46eea40e9d1e91e40087ea@0x7f5744ba61d8 - - /usr/lib/x86_64-linux-gnu/libleveldb.so.1.15
0x7f5744df3000+0x26b000 47a7a1cce3473c29270dd02746aff5ab55e973bd@0x7f5744df3210 - - /usr/lib/libtcmalloc.so.4.1.2
0x7f574505e000+0x21b000 fe705aa7e3872b43ea9e99faf1897f7f85fc0ac9@0x7f574505e248 - - /lib/x86_64-linux-gnu/libresolv-2.19.so
0x7f5745279000+0x204000 da9b8c234d0fe9fd8caac8970a7ec1b6c8f6623f@0x7f5745279248 - - /lib/x86_64-linux-gnu/libdl-2.19.so
0x7f574547d000+0x208000 e2a6dd5048a0a051fd61043bdb69d8cc68192ab7@0x7f574547d248 - - /lib/x86_64-linux-gnu/librt-2.19.so
0x7f5745685000+0x225000 d0f537904076d73f29e4a37341f8a449e2ef6cd0@0x7f57456851d8 - - /lib/x86_64-linux-gnu/ld-2.19.so
0x7f57458aa000+0x8e44000 676271afac0800247251ab72944a7f0cb77ea6e6@0x7f57458aa2bc - - /usr/bin/ceph-mon
0x7fff9e5f4000+0x1000 5c010c1f1414642d6c56d676b45f7d4040811de9@0x7fff9e5f4340 . - linux-vdso.so.1

Now you need to convert the buildids to something you can search for, I have a
one liner that will do that.

$ eu-unstrip -n --core ./1477613184.29410.core|gawk '{TMP=$2; $1=$2=""; print "/usr/lib/debug/.build-id/" substr(TMP,0,2) "/" substr(TMP,3,38) ".debug" $0}'
/usr/lib/debug/.build-id/15/aed4855920e5a0fb8791b683eb88c7e1199260.debug  - - /lib/x86_64-linux-gnu/liblzma.so.5.0.0
/usr/lib/debug/.build-id/1c/49b39b2c476cce4d64c985c8c6829a2ce60146.debug  - - /usr/lib/x86_64-linux-gnu/libplds4.so
/usr/lib/debug/.build-id/52/0a0b74241f21c49a10c7012a9088977654faea.debug  - - /usr/lib/x86_64-linux-gnu/libplc4.so
/usr/lib/debug/.build-id/e2/fa750a304dcaca39c9275cd63ea04aff3a21c8.debug  - - /usr/lib/x86_64-linux-gnu/libnssutil3.so
/usr/lib/debug/.build-id/e1/031ddbffe20367e874b7093eec0c8d9f3b43f6.debug  - - /lib/x86_64-linux-gnu/libbz2.so.1.0.4
/usr/lib/debug/.build-id/7e/e9bc42787a0f9a793bdbfcb0671fd12c52bc2a.debug  - - /lib/x86_64-linux-gnu/libz.so.1.2.8
/usr/lib/debug/.build-id/5a/d278db2b1442d92890e2bf739ae9e2a4334e14.debug  - - /usr/lib/libsnappy.so.1.1.4
/usr/lib/debug/.build-id/11/e7491ee391903dee471d098dd64a94d4f3553f.debug  - - /usr/lib/x86_64-linux-gnu/libunwind.so.8.0.1
/usr/lib/debug/.build-id/cf/699a15caae64f50311fc4655b86dc39a479789.debug  - - /lib/x86_64-linux-gnu/libc-2.19.so
/usr/lib/debug/.build-id/36/311b4457710ae5578c4bf00791ded7359dbb92.debug  - - /lib/x86_64-linux-gnu/libgcc_s.so.1
/usr/lib/debug/.build-id/d1/44258e614900b255a31f3fd2283a878670d5bc.debug  - - /lib/x86_64-linux-gnu/libm-2.19.so
/usr/lib/debug/.build-id/76/190e922af7457d078f75c9b15fa184e83eb506.debug  - - /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.19
/usr/lib/debug/.build-id/db/50880ae5e0a37475fbeae724838f17fc2506b9.debug  - - /usr/lib/x86_64-linux-gnu/libnspr4.so
/usr/lib/debug/.build-id/d9/63167f8b7f289a0d6c1eee3961573154a02e9e.debug  - - /usr/lib/x86_64-linux-gnu/libnss3.so
/usr/lib/debug/.build-id/31/e9f21ae8c10396171f1e13da15780986fa696c.debug  - - /lib/x86_64-linux-gnu/libpthread-2.19.so
/usr/lib/debug/.build-id/97/fe266a233f38fc06da11d70a98d905ebaf4d0c.debug  - - /usr/lib/x86_64-linux-gnu/libboost_iostreams.so.1.54.0
/usr/lib/debug/.build-id/41/ad63d05b8787d608a68db9ff998ce58396718a.debug  - - /usr/lib/x86_64-linux-gnu/libboost_random.so.1.54.0
/usr/lib/debug/.build-id/b2/cbdc11873cd013c5590773223d50d36b141041.debug  - - /usr/lib/x86_64-linux-gnu/libboost_system.so.1.54.0
/usr/lib/debug/.build-id/02/6cddcc8e96b9e4cf0aeba1f9133d65fe32b16d.debug  - - /usr/lib/x86_64-linux-gnu/libboost_thread.so.1.54.0
/usr/lib/debug/.build-id/de/a662096bd6de078c46eea40e9d1e91e40087ea.debug  - - /usr/lib/x86_64-linux-gnu/libleveldb.so.1.15
/usr/lib/debug/.build-id/47/a7a1cce3473c29270dd02746aff5ab55e973bd.debug  - - /usr/lib/libtcmalloc.so.4.1.2
/usr/lib/debug/.build-id/fe/705aa7e3872b43ea9e99faf1897f7f85fc0ac9.debug  - - /lib/x86_64-linux-gnu/libresolv-2.19.so
/usr/lib/debug/.build-id/da/9b8c234d0fe9fd8caac8970a7ec1b6c8f6623f.debug  - - /lib/x86_64-linux-gnu/libdl-2.19.so
/usr/lib/debug/.build-id/e2/a6dd5048a0a051fd61043bdb69d8cc68192ab7.debug  - - /lib/x86_64-linux-gnu/librt-2.19.so
/usr/lib/debug/.build-id/d0/f537904076d73f29e4a37341f8a449e2ef6cd0.debug  - - /lib/x86_64-linux-gnu/ld-2.19.so
/usr/lib/debug/.build-id/67/6271afac0800247251ab72944a7f0cb77ea6e6.debug  - - /usr/bin/ceph-mon
/usr/lib/debug/.build-id/5c/010c1f1414642d6c56d676b45f7d4040811de9.debug  . - linux-vdso.so.1

Then it's a matter of finding a machine running the same OS as the coredump
host and run the following command.

$ yum provides /usr/lib/debug/.build-id/cf/699a15caae64f50311fc4655b86dc39a479789.debug

This will identify the glibc package involved and you can download and unpack
that and the matching debuginfo package. If anyone knows the way to do this on
Ubuntu I'd love to hear it.

Rinse and repeat until you get a good backtrace and note that the system where
you do this can be Fedora, Ubuntu, RHEL, CentOS, and probably many others. GDB
should understand binaries from other OSes than the one you are running. Also
note that although this can be used successfully and it can save a considerable
amount of time in reproducing the coredump host system it is not as foolproof
as doing so so, if you are having trouble, you may end up needing to do so
anyway.

Finally, note that you can use the gdb command "set directories" to tell gdb
where to find the source code if it ships in the debuginfo package from the
distro (rpm based systems generally do) but that this path will need to be set
manually as different packages may have different paths, for example;

(gdb) set directories ./usr/src/debug/glusterfs-3.7.1/glusterfsd/src

If all of the above works you will get very close to a native debugging
environment but it can be fiddly to get right :)

Hope this information is useful.

-- 
Cheers,
Brad

> -Sam
>
>
> On Nov 4, 2016 3:56 AM, "kefu chai" <tchaikov@gmail.com> wrote:
>>
>> hi ceph developers,
>>
>> i just pulled together a simple script at
>> https://github.com/tchaikov/sepia-bt/blob/master/bt.sh for debugging
>> the coredump on teuthology. what it does is
>>
>> 1. download the ceph packages
>> 2. extract them so we have the debugged executable and symbols
>> 3. launch gdb and set the necessary paths
>>
>> et voilà!
>>
>> the idea of this script comes from badone (Brad). i just translate it
>> into a shell script.
>>
>> pull requests welcomed!
>>
>>
>> have a nice Friday!
>>
>> --
>> Regards
>> Kefu Chai
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


