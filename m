From: Dan van der Ster <dan@vanderster.com>
Subject: Re: CDS blueprint: strong auth for cephfs
Date: Thu, 14 Nov 2013 17:21:37 +0100
Message-ID: <CABZ+qqnfkEOVH2QRM8fu95eGEVBZ8JHX-KLGRAca76AymXothg@mail.gmail.com>
References: <CABZ+qqkfhMFUskDheNrARKfyUPCRLref-O=kkw3ezqaZFnu6rw@mail.gmail.com>
 <CAPYLRzgrDPUg91em1uXkCtqFfbS-2GP92stjmGtPUOmS+tRcTw@mail.gmail.com>
 <CABZ+qq=SQman+HPvKany0HigYrtMn766itdU_7ZsYm6SOaQzcQ@mail.gmail.com> <CAPYLRzhKNT6Tx9LRV6bfHXpAsG1m3MhWriK-i-T+wSGfBVwh-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:41693 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288Ab3KNQWU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Nov 2013 11:22:20 -0500
Received: by mail-bk0-f52.google.com with SMTP id u14so1034233bkz.11
        for <ceph-devel@vger.kernel.org>; Thu, 14 Nov 2013 08:22:18 -0800 (PST)
Received: from mail-lb0-x234.google.com (mail-lb0-x234.google.com [2a00:1450:4010:c04::234])
        by mx.google.com with ESMTPSA id l9sm3928131bkg.0.2013.11.14.08.22.18
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 08:22:18 -0800 (PST)
Received: by mail-lb0-f180.google.com with SMTP id u14so1691771lbd.25
        for <ceph-devel@vger.kernel.org>; Thu, 14 Nov 2013 08:22:17 -0800 (PST)
In-Reply-To: <CAPYLRzhKNT6Tx9LRV6bfHXpAsG1m3MhWriK-i-T+wSGfBVwh-A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Arne Wiebalck <Arne.Wiebalck@cern.ch>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, andrea.ieri@cern.ch

On Thu, Nov 14, 2013 at 4:55 PM, Gregory Farnum <greg@inktank.com> wrot=
e:
> On Thu, Nov 14, 2013 at 2:00 AM, Dan van der Ster <dan@vanderster.com=
> wrote:
>> Hi Greg,
>>
>> On Wed, Nov 13, 2013 at 6:45 PM, Gregory Farnum <greg@inktank.com> w=
rote:
>>> On Wed, Nov 13, 2013 at 8:05 AM, Dan van der Ster <dan@vanderster.c=
om> wrote:
>>>> Hi all,
>>>> This mail is just to let you know that we've prepared a draft
>>>> blueprint related to adding strong(er) authn/authz to cephfs:
>>>>
>>>> http://wiki.ceph.com/01Planning/02Blueprints/Firefly/Strong_AuthN_=
and_AuthZ_for_CephFS
>>>>
>>>> The main goal of the idea is that we'd like to be able to use Ceph=
=46S
>>>> from untrusted clients:
>>>>   - the CephX key gives full rw access to pools (e.g. data/metadat=
a)
>>>> via rados; we cannot distribute this key to untrusted hosts.
>>>>   - root on untrusted clients can forge their uid/gid and rm -rf /=
cephfs/*.
>>>>
>>>> In the doc we've proposed one way to add authn/authz to the ceph
>>>> server side, but perhaps there is a simpler (more feasible in the
>>>> short term) solution which would enable us to allow untrusted ceph=
fs
>>>> clients.
>>>
>>> You want to check out:
>>> http://wiki.ceph.com/01Planning/Sideboard/Client_Security_for_CephF=
S,
>>> the previous edition of the client security blueprint
>>
>> AFAICT, this would allow single users to mount a subtree on CephFS a=
nd
>> prevent them from writing where they are not permitted. But our
>> use-case is different: we want to mount /cephfs/ from shared
>> workstations and batch nodes to store personal home directories,
>> shared group areas, and read-only software areas. Managing per-user
>> keyrings and per-user mountpoints would become quickly unmanageable.
>
> Ah, I hadn't gotten that from skimming the blueprint. So this isn't
> just about hooking into Kerberos when we do a mount, you want to
> dynamically retrieve different caps from the monitors as users log on=
,
> and have that single client choose between them based on who's making
> the request?

In our proposal the "additional capabilities" (which allow IOs with a
particular file/object) are encrypted and sent by the MDS to the
client who passes it on to the OSD for object IOs.

>
>>> the MDS tickets in a lot more detail than you have there, though =97=
 for
>>> instance, with your current description you'll need a shared secret
>>> between the OSD and MDS, and you'll need to expire the client extra
>>
>> Right, the shared secret is the kerberos service key in our model.
>
> So the whole Ceph cluster has one shared service key, and they use
> that for securing everything that anybody does? (Sorry, that's
> probably an elementary question, but I haven't looked at Kerberos
> since Yehuda implemented the initial CephX auth.)

We've used the shared service key in the past with other distributed
file systems. But perhaps the model can be changed to per-OSD/MDS
keys.

>
>>> keys, etc. You may want to consider skipping this in the first
>>> iteration and just implementing proper security on the MDS while
>>> relying on RADOS-level options to keep data secure (separate
>>> namespaces or pools for different users, and providing narrow caps =
to
>>> clients). That would also leave more time for some serious research
>>
>> It sounds like like you're referring to the Sideboard above, which
>> unless I'm wrong won't help for our (not uncommon?) use-case.
>
> Yeah. :/
>
> On Thu, Nov 14, 2013 at 5:13 AM, Arne Wiebalck <Arne.Wiebalck@cern.ch=
> wrote:
>> It looks to me like Maat is already pretty close to what the use of =
CephFS on untrusted
>> clients would require.
>>
>> Any idea why Maat does not use a kerberized Ceph service and the cor=
responding
>> shared session keys? I think that could avoid the generation and dis=
tribution of per
>> client keys and outsource the shared key negotation to a standardize=
d mechanism
>> (and allow for integration with existing authN service infrastructur=
es, of course).
>
> I do not. If I were placing bets, because it was a research project
> and they didn't have Kerberos set up already. ;) But they also discus=
s
> the security implications of using a single shared key, and discard i=
t
> because they want the system to remain mostly secure if an attacker
> compromises a machine (and gets access to its keys).
>
>> Also, why was the Maat idea (which was apparently implemented, teste=
d and
>> benchmarked) not integrated into mainline Ceph?
>
> By the time I arrived this was all history; you'll have to wait until
> Sage gets back for that one. I suspect he didn't like the performance
> enough and the trees had diverged non-trivially by the time Maat was
> in a useful state. But if you are brave, you can go back in time
> (couple years ago) and look for the "security" folder, which I think
> contained the Maat changes, and see what would be involved in
> extracting them. :)

Is it this one?
   https://github.com/ceph/ceph/tree/historic/aleung_mds_security/


Cheers, Dan


> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
