From: Gregory Farnum <greg@inktank.com>
Subject: Re: CDS blueprint: strong auth for cephfs
Date: Wed, 13 Nov 2013 09:45:37 -0800
Message-ID: <CAPYLRzgrDPUg91em1uXkCtqFfbS-2GP92stjmGtPUOmS+tRcTw@mail.gmail.com>
References: <CABZ+qqkfhMFUskDheNrARKfyUPCRLref-O=kkw3ezqaZFnu6rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35716 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025Ab3KMRpj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Nov 2013 12:45:39 -0500
Received: by mail-wi0-f173.google.com with SMTP id ey11so5677813wid.12
        for <ceph-devel@vger.kernel.org>; Wed, 13 Nov 2013 09:45:38 -0800 (PST)
In-Reply-To: <CABZ+qqkfhMFUskDheNrARKfyUPCRLref-O=kkw3ezqaZFnu6rw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, andrea.ieri@cern.ch, Arne Wiebalck <Arne.Wiebalck@cern.ch>

On Wed, Nov 13, 2013 at 8:05 AM, Dan van der Ster <dan@vanderster.com> =
wrote:
> Hi all,
> This mail is just to let you know that we've prepared a draft
> blueprint related to adding strong(er) authn/authz to cephfs:
>
> http://wiki.ceph.com/01Planning/02Blueprints/Firefly/Strong_AuthN_and=
_AuthZ_for_CephFS
>
> The main goal of the idea is that we'd like to be able to use CephFS
> from untrusted clients:
>   - the CephX key gives full rw access to pools (e.g. data/metadata)
> via rados; we cannot distribute this key to untrusted hosts.
>   - root on untrusted clients can forge their uid/gid and rm -rf /cep=
hfs/*.
>
> In the doc we've proposed one way to add authn/authz to the ceph
> server side, but perhaps there is a simpler (more feasible in the
> short term) solution which would enable us to allow untrusted cephfs
> clients.

You want to check out:
http://wiki.ceph.com/01Planning/Sideboard/Client_Security_for_CephFS,
the previous edition of the client security blueprint
http://www.ssrc.ucsc.edu/Papers/leung-sc07.pdf, "Scalable Security for
Petascale Parallel File Systems", which discusses one way of using
MDS-granted permissions
http://www.ssrc.ucsc.edu/Papers/li-fast13.pdf, "Horus: Fine-Grained
Encryption-Based Security for Large-Scale Storage" is largely
orthogonal in specifics but might inspire some other ides

It looks to me like you've actually got two different blueprints
there, though =96 "Allow Ceph clients to use Kerberos as an entry point=
"
and "Enable stronger CephFS security". You're going to need to discuss
the MDS tickets in a lot more detail than you have there, though =97 fo=
r
instance, with your current description you'll need a shared secret
between the OSD and MDS, and you'll need to expire the client extra
keys, etc. You may want to consider skipping this in the first
iteration and just implementing proper security on the MDS while
relying on RADOS-level options to keep data secure (separate
namespaces or pools for different users, and providing narrow caps to
clients). That would also leave more time for some serious research
into how to do a scalable implementation of any ticketing system we
create.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
