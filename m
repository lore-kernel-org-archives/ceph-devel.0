From: Dan van der Ster <dan@vanderster.com>
Subject: Re: CDS blueprint: strong auth for cephfs
Date: Thu, 14 Nov 2013 11:00:28 +0100
Message-ID: <CABZ+qq=SQman+HPvKany0HigYrtMn766itdU_7ZsYm6SOaQzcQ@mail.gmail.com>
References: <CABZ+qqkfhMFUskDheNrARKfyUPCRLref-O=kkw3ezqaZFnu6rw@mail.gmail.com>
 <CAPYLRzgrDPUg91em1uXkCtqFfbS-2GP92stjmGtPUOmS+tRcTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:47773 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab3KNKBL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Nov 2013 05:01:11 -0500
Received: by mail-bk0-f51.google.com with SMTP id my10so226377bkb.38
        for <ceph-devel@vger.kernel.org>; Thu, 14 Nov 2013 02:01:09 -0800 (PST)
Received: from mail-lb0-x229.google.com (mail-lb0-x229.google.com [2a00:1450:4010:c04::229])
        by mx.google.com with ESMTPSA id on10sm2016472bkb.13.2013.11.14.02.01.08
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 02:01:08 -0800 (PST)
Received: by mail-lb0-f169.google.com with SMTP id x18so176420lbi.14
        for <ceph-devel@vger.kernel.org>; Thu, 14 Nov 2013 02:01:08 -0800 (PST)
In-Reply-To: <CAPYLRzgrDPUg91em1uXkCtqFfbS-2GP92stjmGtPUOmS+tRcTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, andrea.ieri@cern.ch, Arne Wiebalck <Arne.Wiebalck@cern.ch>

Hi Greg,

On Wed, Nov 13, 2013 at 6:45 PM, Gregory Farnum <greg@inktank.com> wrot=
e:
> On Wed, Nov 13, 2013 at 8:05 AM, Dan van der Ster <dan@vanderster.com=
> wrote:
>> Hi all,
>> This mail is just to let you know that we've prepared a draft
>> blueprint related to adding strong(er) authn/authz to cephfs:
>>
>> http://wiki.ceph.com/01Planning/02Blueprints/Firefly/Strong_AuthN_an=
d_AuthZ_for_CephFS
>>
>> The main goal of the idea is that we'd like to be able to use CephFS
>> from untrusted clients:
>>   - the CephX key gives full rw access to pools (e.g. data/metadata)
>> via rados; we cannot distribute this key to untrusted hosts.
>>   - root on untrusted clients can forge their uid/gid and rm -rf /ce=
phfs/*.
>>
>> In the doc we've proposed one way to add authn/authz to the ceph
>> server side, but perhaps there is a simpler (more feasible in the
>> short term) solution which would enable us to allow untrusted cephfs
>> clients.
>
> You want to check out:
> http://wiki.ceph.com/01Planning/Sideboard/Client_Security_for_CephFS,
> the previous edition of the client security blueprint

AFAICT, this would allow single users to mount a subtree on CephFS and
prevent them from writing where they are not permitted. But our
use-case is different: we want to mount /cephfs/ from shared
workstations and batch nodes to store personal home directories,
shared group areas, and read-only software areas. Managing per-user
keyrings and per-user mountpoints would become quickly unmanageable.

> http://www.ssrc.ucsc.edu/Papers/leung-sc07.pdf, "Scalable Security fo=
r
> Petascale Parallel File Systems", which discusses one way of using
> MDS-granted permissions
> http://www.ssrc.ucsc.edu/Papers/li-fast13.pdf, "Horus: Fine-Grained
> Encryption-Based Security for Large-Scale Storage" is largely
> orthogonal in specifics but might inspire some other ides
>

Thanks! I'll take a look.

> It looks to me like you've actually got two different blueprints
> there, though =96 "Allow Ceph clients to use Kerberos as an entry poi=
nt"
> and "Enable stronger CephFS security". You're going to need to discus=
s

It's true, they are separable, but strong authn would have little
utility without strong authz, and vice versa.

> the MDS tickets in a lot more detail than you have there, though =97 =
for
> instance, with your current description you'll need a shared secret
> between the OSD and MDS, and you'll need to expire the client extra

Right, the shared secret is the kerberos service key in our model.

> keys, etc. You may want to consider skipping this in the first
> iteration and just implementing proper security on the MDS while
> relying on RADOS-level options to keep data secure (separate
> namespaces or pools for different users, and providing narrow caps to
> clients). That would also leave more time for some serious research

It sounds like like you're referring to the Sideboard above, which
unless I'm wrong won't help for our (not uncommon?) use-case.

Cheers, Dan

> into how to do a scalable implementation of any ticketing system we
> create.
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
