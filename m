From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: OSD-Based Object Stubs
Date: Wed, 27 May 2015 10:37:38 -0600
Message-ID: <CAANLjFriAw_RcWvkGBvt_2EwzicTQCF1ygymyDwbi8z4H-i3jQ@mail.gmail.com>
References: <87a8wqct38.fsf@irq0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35532 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbbE0Qhk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 May 2015 12:37:40 -0400
Received: by wicmx19 with SMTP id mx19so117890376wic.0
        for <ceph-devel@vger.kernel.org>; Wed, 27 May 2015 09:37:38 -0700 (PDT)
In-Reply-To: <87a8wqct38.fsf@irq0.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcel Lauhoff <ml@irq0.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

At first I thought this was to allow the OSDs to stub the location of
the real data after a CRUSH map change so that it didn't have to
relocate the data right away (or at all) and reduce the  number of map
changes. Then I realized it was for cold storage tiering. Is the idea
to be able to move data off to near-line storage like tape?

Thanks,
- ----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Wed, May 27, 2015 at 2:39 AM, Marcel Lauhoff  wrote:
> Hi,
>
> I wrote a prototype for an OSD-based object stub feature. An object stub
> being an object with it's data moved /elsewhere/. I hope to get some
> feedback, especially whether I'm on the right path here and if it
> is a feature you are interested in.
>
>
>
> Code is in my "osd-stubs" branch:
>  https://github.com/ceph/ceph/compare/master...irq0:osd-stubs
>  https://github.com/irq0/ceph/tree/osd-stubs
>
>  Tools to toy around with osd-stubs + web server to send stubs to:
>  https://github.com/irq0/ceph_osd-stub_tools
>
>
>
> Related:
> - https://wiki.ceph.com/Planning/Blueprints/%3CSIDEBOARD%3E/osd:_tiering:_object_redirects
>
>
>
> Implementation:
>
> Adds two new OSD OPs:
> - STUB :: Move data away; Save location in xattr; Set
>           object_info_t::stub_state to 'remote'
> - UNSTUB :: Get data back; Remove xattr; Set object_info_t::stub_state
>             to 'local'
>
>
> STUB is meant to be called by an external archive agent. UNSTUB
> implicitly when OPs come in that need the object's data. Operations are
> classified as "may_use_obj_data" similar to how op->may_{write,read,cache} work.
>
> The implicit UNSUB is implemented by prepending an UNSTUB operation to the
> incoming OP list if "may_use_obj_data() and stub_state == REMOTE".
> This sadly causes a waring in the client saying that
> the reply doesn't match the request. He is of course right, but I found
> it to be the simplest way to try that feature.
>
> External storage in the prototype is just simple HTTP: PUT on STUB;
> GET+DELETE on UNSTUB.
>
> The Operations implement a kind of converter: STUB reads from the
> primary OSD, store the object on the remote and then issue TRUNCATE(0)
> and SETXATTR OPs. Similar UNSTUB retrieves the object, then does
> WRITEFULL and RMXATTR.
>
>
> ~marcel
>
> --
> Marcel Lauhoff
> Mail/XMPP: ml@irq0.org
> http://irq0.org
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVZfK8CRDmVDuy+mK58QAAQUAP/jCje1UlnbYJYlLc2aLC
OkXBPRTQH1+kza7uloibEpZLaaQpJ3IP+ttBjzbUz3w4DC6Gh31nJgWzidFL
qji/b9qIRNBRquypR575K17PtK2xuudFnIObcaGCgmQ36XHcMqjFZYON6I4Q
wE+kptkFCbSzo+5JBZsJwsjrQNpVMonSxaSZ08WNamslIWhKuLpFfWF49YyW
Aq9YiSehXxiWpUU880FyDY/WNLqflWrWUSXXt+T/cYzzGb9BXAH4jEJl2Dtn
QIothZZeabDs+QpF9dxL3teOlHhcqHjPdPOK102/67E+hZz91PTVzf5r3Egs
B2OEL3AbjsYk3A5EZK5rxxd4Judc+glDYKq4H+wVFhVFiuBrcv/UsIFx/ZHH
9nJijKQFu/JKJzrkl0ubZDZodXSyR7h+dBUnPwiKNZvBWqwR5BaYJepEl82H
hTr3GslhLg1MpaMGqST7yOtR7BxZTb4+U5LhCUZXW5JFvjkNM0kS8VgtnkPP
OsPLETq8kTAsnxCzbRtwFIZSW0236Rf2z9naazbgmaZW/uwjlz2rWaxSw8zA
+uYBo6dEO7GhhUPrgJW/EiVkqEpwXRqd2hYSeiD63Bz8/efxSExAaoFgHPRt
fDRJKHheDmzzYRtOHX21QTV6Lnw9hpjdmC27WAmEfvTNCmLWrzXeF4SS/g1g
3/+W
=7BjB
-----END PGP SIGNATURE-----
