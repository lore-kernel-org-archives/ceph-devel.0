From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: "Radosgw installation and administration" docs
Date: Tue, 12 Jun 2012 11:54:51 -0700
Message-ID: <CAC-hyiF5PVR9nzjewG6VjPCGdjAeuio8Gqf9_juZKWRZZ1KpaQ@mail.gmail.com>
References: <4FD71854.6060503@hastexo.com>
	<CAPUexz-nq-rs3CdougTBpiiur__W0royUcaMdYfpfamwkh7jNw@mail.gmail.com>
	<CAC-hyiEDLJTkDKXLgR64cPE5mcPvWUCs6kCCq+DiRaCtvDEEFQ@mail.gmail.com>
	<4FD78636.9080607@hastexo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64018 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab2FLSyx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jun 2012 14:54:53 -0400
Received: by bkcji2 with SMTP id ji2so4800266bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 12 Jun 2012 11:54:51 -0700 (PDT)
In-Reply-To: <4FD78636.9080607@hastexo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jun 12, 2012 at 11:11 AM, Florian Haas <florian@hastexo.com> wr=
ote:
> Hi Yehuda,
>
> thanks, that resolved a lot of questions for me. A few follow-up
> comments below:
>
>>
>> We currently use a slightly different rule:
>>
>> =A0 RewriteRule =A0 =A0 =A0 =A0 =A0 =A0 ^/(.*)
>> /radosgw.fcgi?params=3D$1&%{QUERY_STRING}
>> [E=3DHTTP_AUTHORIZATION:%{HTTP:Authorization},L]
>
> Could you explain what happened to "page"?

Not really. I don't remember, was probably necessary originally and
now it's not. Looking at the code, I think you can also drop the
params=3D$1 part:

  RewriteRule             ^/(.*) /radosgw.fcgi?%{QUERY_STRING}
[E=3DHTTP_AUTHORIZATION:%{HTTP:Authorization},L]

>
>>> Also, for each of these, where would the logging output end up?
>>> /var/log/ceph? Apache error log? If so, only if the Apache LogLevel=
 is
>>> more verbose than info? Syslog?
>>
>>
>> The debug log would end up wherever you specified in the 'log file'
>> config option.
>
> ... or syslog, if log file =3D "" and syslog =3D true. (iirc)

Yeah. Whichever ceph logging scheme you're using.

>
>>> 6. Swift API: Keys
>>>
>>> Is it correct to assume that for any Swift client to work, we must =
set a
>>> Swift key for the user, like so?
>>>
>>> radosgw-admin key create --key-type=3Dswift --uid=3D<user>
>>>
>>> If so, is the secret_key that that creates for the user:
>>>
>>> =A0"swift_keys": [
>>> =A0 =A0 =A0 =A0{ "user": "<user>",
>>> =A0 =A0 =A0 =A0 =A0"secret_key": "<longbase64hash>"}]}
>>>
>>>
>>> ... the same key that the swift command line client expects to be s=
et
>>> with th -K option?
>>
>> Yes.
>
> OK, but I realized that you apparently have to create a separate key
> when creating a sub-user. Is that correct? Or is there a way for
> sub-users to "inherit" the keys defined for their parent user?
>
>>> 7. Swift API: swift user name
>>>
>>> When we call "swift -U <user>", is that the verbatim user_id that w=
e've
>>> defined with "radosgw-admin user create --uid=3D<user_id>"? Or do w=
e need
>>> to set a prefix? Or define a separate Swift user ID?
>>>
>>
>> In swift the terminology is a bit different. There is the account an=
d
>> under that there is the user. Since we already have a 'user' (which =
is
>> actually the swift account), we created a 'subuser'. So a one liner
>> user and swift-subuser creation would be as follows:
>>
>> # radosgw-admin user create --subuser=3Dyehuda:yehuda1
>> --display-name=3DYehuda --key-type=3Dswift --access=3Dfull
>
> It seems there is some magic involved so that if you do "user create"=
,
> set --subuser=3D<prefix>:<sub> and don't set --uid, it creates a new
> parent user named <prefix>. Is this meant to be stable? Or is the

The <user>:<subuser> notation is stable.

> supported way of doing things to always first create a user, and then
> use "subuser create" to create the subuser?

Both are supported, but note that the 'user create' command requires a
display-name to be specified, whereas the 'subuser create' doesn't. We
can change that later and only require the display-name if the user
does not exist, but at the moment that's how it works.

>
>> { "user_id": "yehuda",
>> =A0 "rados_uid": 0,
>> =A0 "display_name": "Yehuda",
>> =A0 "email": "",
>> =A0 "suspended": 0,
>> =A0 "max_buckets": 1000,
>> =A0 "subusers": [
>> =A0 =A0 =A0 =A0 { "id": "yehuda:yehuda1",
>> =A0 =A0 =A0 =A0 =A0 "permissions": "full-control"}],
>> =A0 "keys": [],
>> =A0 "swift_keys": [
>> =A0 =A0 =A0 =A0 { "user": "yehuda:yehuda1",
>> =A0 =A0 =A0 =A0 =A0 "secret_key": "7TD5f2QrwxkCnhthwowC4d9uEJ4mnX8nG=
sXjmnW8"}]}
>>
>
>>> 10. radosgw "OpenStack user" information
>>>
>>> From the radosgw-admin man page:
>>> =A0 =A0 =A0 --os-user=3Dgroup:name
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0The OpenStack user (only needed for use =
with OpenStack)
>>> =A0 =A0 =A0 --os-secret=3Dkey
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0The OpenStack key
>>
>> Obsolete. That was the old way to configure swift users.
>
> OK. Should this be removed from the man page then?

Yeah, should be updated.

>
> Silly question: If "auth supported =3D none", is it still required to=
 run
> the ceph-authtool and ceph-auth commands specified in radosgw(8)?

Not for setting up radosgw.

>> =A0 =A0 =A0 =A0 log file =3D /var/log/radosgw/radosgw.log
>> =A0 =A0 =A0 =A0 debug rgw =3D 20
>> =A0 =A0 =A0 =A0 rgw cache enabled =3D 1
>> ; =A0 =A0 =A0 rgw swift url =3D http://skinny
>> ; =A0 =A0 =A0 rgw swift url prefix =3D swift
>
> I ran across this option sifting through src/rgw, can you explain wha=
t
> the URL prefix is used for?

When authenticating the client, the swift_url and swift_prefix are
concatenated and passed to the client as the storage URL, along with
the token.



Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
