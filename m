From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw forgetting subuser permissions when creating a fresh key
Date: Mon, 25 Jun 2012 09:40:07 -0700
Message-ID: <CAC-hyiHsAzg9zG--KmcQPeF5gLjstHRdOBSA9yBxp7CTcGC_qQ@mail.gmail.com>
References: <CAPUexz-dojn2sgsox0OaMMar=ptYUkExQcQd8=VoyvFe2XCq3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59087 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001Ab2FYQkI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jun 2012 12:40:08 -0400
Received: by bkcji2 with SMTP id ji2so3349182bkc.19
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jun 2012 09:40:07 -0700 (PDT)
In-Reply-To: <CAPUexz-dojn2sgsox0OaMMar=ptYUkExQcQd8=VoyvFe2XCq3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jun 25, 2012 at 4:57 AM, Florian Haas <florian@hastexo.com> wro=
te:
> Hi everyone,
>
> I wonder if this is intentional: when I create a new Swift key for an
> existing subuser, which has previously been assigned "full control"
> permissions, those permissions appear to get lost upon key creation.
>
> # radosgw-admin subuser create --uid=3Djohndoe --subuser=3Djohndoe:sw=
ift
> --access=3Dfull
> { "user_id": "johndoe",
> =A0"rados_uid": 0,
> =A0"display_name": "John Doe",
> =A0"email": "john@example.com",
> =A0"suspended": 0,
> =A0"subusers": [
> =A0 =A0{ "id": "johndoe:swift",
> =A0 =A0 =A0"permissions": "full-control"}],
> =A0"keys": [
> =A0 =A0{ "user": "johndoe",
> =A0 =A0 =A0"access_key": "QFAMEDSJP5DEKJO0DDXY",
> =A0 =A0 =A0"secret_key": "iaSFLDVvDdQt6lkNzHyW4fPLZugBAI1g17LO0+87"}]=
,
> =A0"swift_keys": []}
>
> Note "permissions": "full-control"
>
> # radosgw-admin key create --subuser=3Djohndoe:swift --key-type=3Dswi=
ft
> { "user_id": "johndoe",
> =A0"rados_uid": 0,
> =A0"display_name": "John Doe",
> =A0"email": "john@example.com",
> =A0"suspended": 0,
> =A0"subusers": [
> =A0 =A0 { "id": "johndoe:swift",
> =A0 =A0 =A0 "permissions": "<none>"}],
> =A0"keys": [
> =A0 =A0{ "user": "johndoe",
> =A0 =A0 =A0"access_key": "QFAMEDSJP5DEKJO0DDXY",
> =A0 =A0 =A0"secret_key": "iaSFLDVvDdQt6lkNzHyW4fPLZugBAI1g17LO0+87"}]=
,
> =A0"swift_keys": [
> =A0 =A0{ "user": "johndoe:swift",
> =A0 =A0 =A0"secret_key": "E9T2rUZNu2gxUjcwUBO8n\/Ev4KX6\/GprEuH4qhu1"=
}]}
>
> Note that while there is now a key, the permissions are gone. Is this
> meant to be a security feature of sorts, or is this a bug? "subuser
> modify" can obviously restore the permissions, but it seems to be les=
s
> than desirable to have to do that.
>
I'm having trouble assigning a security reasoning behind this one, so
let's just call it a bug. I opened issue #2650, and pushed branch
wip-2650 with a possible fix. You can cherry pick the top commit there
and test it.

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
