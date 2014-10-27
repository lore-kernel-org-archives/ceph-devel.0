From: Samuel Just <sam.just@inktank.com>
Subject: Re: OSDs crashing with Operation Not Permitted on reading PGLog
Date: Mon, 27 Oct 2014 15:10:34 -0700
Message-ID: <CA+4uBUZAfYcKqqPS2KriXARyarVk8HKNaBS11trPdfpxwjUJzw@mail.gmail.com>
References: <544EB2EF.1000808@42on.com>
	<CA+4uBUaN8STAmfE7CkQvrBPK8UUGiybRbvgfMWbKp1784gVDaw@mail.gmail.com>
	<544EB623.8090205@42on.com>
	<CA+4uBUbM7zaEuJik4=fG7fVhn-WWFh8mwXMGjrV_FRRW_EksTg@mail.gmail.com>
	<544EBC91.6060108@42on.com>
	<CA+4uBUYBzmYaiNq69d3tS-QHOE4ywks9_uYJFuxpsyVXFmyTSA@mail.gmail.com>
	<544EBE0E.20304@42on.com>
	<CA+4uBUY2Ddcs0YffY4Z1e2fCFvE387hyuMvE+PBhMtBJY87yDA@mail.gmail.com>
	<544EBEC8.2060900@42on.com>
	<CA+4uBUaC+C2H3bFPcuetsu2O9p=8POYOJpb2C183-vC=n0e6RA@mail.gmail.com>
	<544EBF8C.10309@42on.com>
	<CA+4uBUYnymMAjCUjHjzi_dNNmu7gCjfMBsNJETa2_T5c=JxvBA@mail.gmail.com>
	<544EC286.3090609@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:59129 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbaJ0WKg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 18:10:36 -0400
Received: by mail-lb0-f176.google.com with SMTP id p9so6432206lbv.7
        for <ceph-devel@vger.kernel.org>; Mon, 27 Oct 2014 15:10:34 -0700 (PDT)
In-Reply-To: <544EC286.3090609@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

You might try asking the leveldb folks about possibly repairing it.
-Sam

On Mon, Oct 27, 2014 at 3:09 PM, Wido den Hollander <wido@42on.com> wrote:
> On 10/27/2014 11:00 PM, Samuel Just wrote:
>> Try running with osd_leveldb_paranoid=true and
>> osd_leveldb_log=/var/log/ceph/osd/ceph-osd.<id>.log.leveldb on that
>> osd.
>
> Done and it was quite a clear message from leveldb:
>
> 2014/10/27-23:06:56.525355 7f14d0ea9800 Recovering log #164296
> 2014/10/27-23:06:56.554527 7f14d0ea9800 Delete type=0 #164296
> 2014/10/27-23:06:56.554644 7f14d0ea9800 Delete type=2 #164297
> 2014/10/27-23:06:56.555415 7f14d0ea9800 Delete type=2 #164298
> 2014/10/27-23:06:56.555709 7f14d0ea9800 Delete type=3 #164295
> 2014/10/27-23:06:56.556116 7f14cbc45700 Compacting 1@1 + 2@2 files
> 2014/10/27-23:06:56.626336 7f14cbc45700 Generated table #164299: 57
> keys, 2193624 bytes
> 2014/10/27-23:06:56.642292 7f14cbc45700 compacted to: files[ 10 15 32 0
> 0 0 0 ]
> 2014/10/27-23:06:56.642310 7f14cbc45700 Compaction error: Corruption:
> block checksum mismatch
>
> What happened at this cluster is that a admin made a mistake and
> accidentally resetted all machines using the IPMI, so all the
> filesystems (and thus leveldb) were not closed properly.
>
> 5 OSDs however didn't seem to have survived. (Which now causes 4 PGs to
> be down).
>
> Wido
>
>> -Sam
>>
>> On Mon, Oct 27, 2014 at 2:56 PM, Wido den Hollander <wido@42on.com> wrote:
>>> On 10/27/2014 10:55 PM, Samuel Just wrote:
>>>> There is nothing in dmesg?
>>>
>>> No. The filesystem mounts cleanly and I even ran xfs_repair to see if
>>> there was anything wrong with it.
>>>
>>> All goes just fine. It's only the OSD which is crashing.
>>>
>>> Wido
>>>
>>>> -Sam
>>>>
>>>> On Mon, Oct 27, 2014 at 2:53 PM, Wido den Hollander <wido@42on.com> wrote:
>>>>> On 10/27/2014 10:52 PM, Samuel Just wrote:
>>>>>> I mean, the 5 osds, different nodes?
>>>>>
>>>>> Yes. The cluster consists out of 16 nodes and all these OSDs are on
>>>>> different nodes.
>>>>>
>>>>> All running Ubuntu 12.04 with Ceph 0.80.7
>>>>>
>>>>> Wido
>>>>>
>>>>>> -Sam
>>>>>>
>>>>>> On Mon, Oct 27, 2014 at 2:50 PM, Wido den Hollander <wido@42on.com> wrote:
>>>>>>> On 10/27/2014 10:48 PM, Samuel Just wrote:
>>>>>>>> Different nodes?
>>>>>>>
>>>>>>> No, they are both from osd.25
>>>>>>>
>>>>>>> I re-ran the strace with a empty logfile since the old logfile became
>>>>>>> pretty big.
>>>>>>>
>>>>>>> Wido
>>>>>>>
>>>>>>>> -Sam
>>>>>>>>
>>>>>>>> On Mon, Oct 27, 2014 at 2:43 PM, Wido den Hollander <wido@42on.com> wrote:
>>>>>>>>> On 10/27/2014 10:35 PM, Samuel Just wrote:
>>>>>>>>>> The file is supposed to be 0 bytes, can you attach the log which went
>>>>>>>>>> with that strace?
>>>>>>>>>
>>>>>>>>> Yes, two URLs:
>>>>>>>>>
>>>>>>>>> * http://ceph.o.auroraobjects.eu/ceph-osd.25.log.gz
>>>>>>>>> * http://ceph.o.auroraobjects.eu/ceph-osd.25.strace.gz
>>>>>>>>>
>>>>>>>>> It was with debug_filestore on 20.
>>>>>>>>>
>>>>>>>>> Wido
>>>>>>>>>
>>>>>>>>>> -Sam
>>>>>>>>>>
>>>>>>>>>> On Mon, Oct 27, 2014 at 2:16 PM, Wido den Hollander <wido@42on.com> wrote:
>>>>>>>>>>> On 10/27/2014 10:05 PM, Samuel Just wrote:
>>>>>>>>>>>> Try reproducing with an strace.
>>>>>>>>>>>
>>>>>>>>>>> I did so and this is the result:
>>>>>>>>>>> http://ceph.o.auroraobjects.eu/ceph-osd.25.strace.gz
>>>>>>>>>>>
>>>>>>>>>>> It does this stat:
>>>>>>>>>>>
>>>>>>>>>>> stat("/var/lib/ceph/osd/ceph-25/current/meta/DIR_D/DIR_C"
>>>>>>>>>>>
>>>>>>>>>>> That fails with: -1 ENOENT (No such file or directory)
>>>>>>>>>>>
>>>>>>>>>>> Afterwards it open this pglog:
>>>>>>>>>>> /var/lib/ceph/osd/ceph-25/current/meta/DIR_D/pglog\\u14.1a56__0_A1630ECD__none
>>>>>>>>>>>
>>>>>>>>>>> That file is however 0 bytes. (And all other files in the same directory).
>>>>>>>>>>>
>>>>>>>>>>> Afterwards the OSD asserts and writes to the log.
>>>>>>>>>>>
>>>>>>>>>>> Wido
>>>>>>>>>>>
>>>>>>>>>>>> -Sam
>>>>>>>>>>>>
>>>>>>>>>>>> On Mon, Oct 27, 2014 at 2:02 PM, Wido den Hollander <wido@42on.com> wrote:
>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>
>>>>>>>>>>>>> On a 0.80.7 cluster I'm experiencing a couple of OSDs refusing to start
>>>>>>>>>>>>> due to a crash they encounter when reading the PGLog.
>>>>>>>>>>>>>
>>>>>>>>>>>>> A snippet of the log:
>>>>>>>>>>>>>
>>>>>>>>>>>>>    -11> 2014-10-27 21:56:04.690046 7f034a006800 10
>>>>>>>>>>>>> filestore(/var/lib/ceph/osd/ceph-25) _do_transaction on 0x392e600
>>>>>>>>>>>>>    -10> 2014-10-27 21:56:04.690078 7f034a006800 20
>>>>>>>>>>>>> filestore(/var/lib/ceph/osd/ceph-25) _check_global_replay_guard no xattr
>>>>>>>>>>>>>     -9> 2014-10-27 21:56:04.690140 7f034a006800 20
>>>>>>>>>>>>> filestore(/var/lib/ceph/osd/ceph-25) _check_replay_guard no xattr
>>>>>>>>>>>>>     -8> 2014-10-27 21:56:04.690150 7f034a006800 15
>>>>>>>>>>>>> filestore(/var/lib/ceph/osd/ceph-25) touch meta/a1630ecd/pglog_14.1a56/0//-1
>>>>>>>>>>>>>     -7> 2014-10-27 21:56:04.690184 7f034a006800 10
>>>>>>>>>>>>> filestore(/var/lib/ceph/osd/ceph-25) touch
>>>>>>>>>>>>> meta/a1630ecd/pglog_14.1a56/0//-1 = 0
>>>>>>>>>>>>>     -6> 2014-10-27 21:56:04.690196 7f034a006800 15
>>>>>>>>>>>>> filestore(/var/lib/ceph/osd/ceph-25) _omap_rmkeys
>>>>>>>>>>>>> meta/a1630ecd/pglog_14.1a56/0//-1
>>>>>>>>>>>>>     -5> 2014-10-27 21:56:04.690290 7f034a006800 10 filestore oid:
>>>>>>>>>>>>> a1630ecd/pglog_14.1a56/0//-1 not skipping op, *spos 1435883.0.2
>>>>>>>>>>>>>     -4> 2014-10-27 21:56:04.690295 7f034a006800 10 filestore  >
>>>>>>>>>>>>> header.spos 0.0.0
>>>>>>>>>>>>>     -3> 2014-10-27 21:56:04.690314 7f034a006800  0
>>>>>>>>>>>>> filestore(/var/lib/ceph/osd/ceph-25)  error (1) Operation not permitted
>>>>>>>>>>>>> not handled on operation 33 (1435883.0.2, or op 2, counting from 0)
>>>>>>>>>>>>>     -2> 2014-10-27 21:56:04.690325 7f034a006800  0
>>>>>>>>>>>>> filestore(/var/lib/ceph/osd/ceph-25) unexpected error code
>>>>>>>>>>>>>     -1> 2014-10-27 21:56:04.690327 7f034a006800  0
>>>>>>>>>>>>> filestore(/var/lib/ceph/osd/ceph-25)  transaction dump:
>>>>>>>>>>>>> { "ops": [
>>>>>>>>>>>>>         { "op_num": 0,
>>>>>>>>>>>>>           "op_name": "nop"},
>>>>>>>>>>>>>         { "op_num": 1,
>>>>>>>>>>>>>           "op_name": "touch",
>>>>>>>>>>>>>           "collection": "meta",
>>>>>>>>>>>>>           "oid": "a1630ecd\/pglog_14.1a56\/0\/\/-1"},
>>>>>>>>>>>>>         { "op_num": 2,
>>>>>>>>>>>>>           "op_name": "omap_rmkeys",
>>>>>>>>>>>>>           "collection": "meta",
>>>>>>>>>>>>>           "oid": "a1630ecd\/pglog_14.1a56\/0\/\/-1"},
>>>>>>>>>>>>>         { "op_num": 3,
>>>>>>>>>>>>>           "op_name": "omap_setkeys",
>>>>>>>>>>>>>           "collection": "meta",
>>>>>>>>>>>>>           "oid": "a1630ecd\/pglog_14.1a56\/0\/\/-1",
>>>>>>>>>>>>>           "attr_lens": { "can_rollback_to": 12}}]}
>>>>>>>>>>>>>      0> 2014-10-27 21:56:04.691992 7f034a006800 -1 os/FileStore.cc: In
>>>>>>>>>>>>> function 'unsigned int
>>>>>>>>>>>>> FileStore::_do_transaction(ObjectStore::Transaction&, uint64_t, int,
>>>>>>>>>>>>> ThreadPool::TPHandle*)' thread 7f034a006800 time 2014-10-27 21:56:04.690368
>>>>>>>>>>>>> os/FileStore.cc: 2559: FAILED assert(0 == "unexpected error")
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> The backing XFS filesystem seems to be OK, but isn't this a leveldb
>>>>>>>>>>>>> issue where the omap information is stored?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Anyone seen this before? I have about 5 OSDs (out of the 336) which are
>>>>>>>>>>>>> showing this problem when booting.
>>>>>>>>>>>>>
>>>>>>>>>>>>> --
>>>>>>>>>>>>> Wido den Hollander
>>>>>>>>>>>>> 42on B.V.
>>>>>>>>>>>>> Ceph trainer and consultant
>>>>>>>>>>>>>
>>>>>>>>>>>>> Phone: +31 (0)20 700 9902
>>>>>>>>>>>>> Skype: contact42on
>>>>>>>>>>>>> --
>>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> --
>>>>>>>>>>> Wido den Hollander
>>>>>>>>>>> 42on B.V.
>>>>>>>>>>> Ceph trainer and consultant
>>>>>>>>>>>
>>>>>>>>>>> Phone: +31 (0)20 700 9902
>>>>>>>>>>> Skype: contact42on
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> Wido den Hollander
>>>>>>>>> 42on B.V.
>>>>>>>>> Ceph trainer and consultant
>>>>>>>>>
>>>>>>>>> Phone: +31 (0)20 700 9902
>>>>>>>>> Skype: contact42on
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> Wido den Hollander
>>>>>>> 42on B.V.
>>>>>>> Ceph trainer and consultant
>>>>>>>
>>>>>>> Phone: +31 (0)20 700 9902
>>>>>>> Skype: contact42on
>>>>>
>>>>>
>>>>> --
>>>>> Wido den Hollander
>>>>> 42on B.V.
>>>>> Ceph trainer and consultant
>>>>>
>>>>> Phone: +31 (0)20 700 9902
>>>>> Skype: contact42on
>>>
>>>
>>> --
>>> Wido den Hollander
>>> 42on B.V.
>>> Ceph trainer and consultant
>>>
>>> Phone: +31 (0)20 700 9902
>>> Skype: contact42on
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> Wido den Hollander
> 42on B.V.
> Ceph trainer and consultant
>
> Phone: +31 (0)20 700 9902
> Skype: contact42on
