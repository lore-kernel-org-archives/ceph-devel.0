From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: "Radosgw installation and administration" docs
Date: Tue, 3 Jul 2012 10:45:10 -0700
Message-ID: <CAC-hyiFkT=H7C1kK0aPau2oett+GhD4QLad06wdZqFHSRi+3+A@mail.gmail.com>
References: <4FD71854.6060503@hastexo.com>
	<CAPUexz-nq-rs3CdougTBpiiur__W0royUcaMdYfpfamwkh7jNw@mail.gmail.com>
	<CAC-hyiEDLJTkDKXLgR64cPE5mcPvWUCs6kCCq+DiRaCtvDEEFQ@mail.gmail.com>
	<4FD78636.9080607@hastexo.com>
	<CAC-hyiF5PVR9nzjewG6VjPCGdjAeuio8Gqf9_juZKWRZZ1KpaQ@mail.gmail.com>
	<loom.20120701T222011-780@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:32876 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252Ab2GCRpM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 13:45:12 -0400
Received: by bkwj10 with SMTP id j10so1942117bkw.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jul 2012 10:45:10 -0700 (PDT)
In-Reply-To: <loom.20120701T222011-780@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chuanyu <chuanyu@cs.nctu.edu.tw>
Cc: ceph-devel@vger.kernel.org

On Sun, Jul 1, 2012 at 1:22 PM, Chuanyu <chuanyu@cs.nctu.edu.tw> wrote:
> Yehuda Sadeh <yehuda <at> inktank.com> writes:
>
>>
>> On Tue, Jun 12, 2012 at 11:11 AM, Florian Haas <florian <at> hastexo.com>
> wrote:
>> > Hi Yehuda,
>> >
>> > thanks, that resolved a lot of questions for me. A few follow-up
>> > comments below:
>> >
>> >>
>> >> We currently use a slightly different rule:
>> >>
>> >>   RewriteRule             ^/(.*)
>> >> /radosgw.fcgi?params=$1&%{QUERY_STRING}
>> >> [E=HTTP_AUTHORIZATION:%{HTTP:Authorization},L]
>> >
>> > Could you explain what happened to "page"?
>>
>> Not really. I don't remember, was probably necessary originally and
>> now it's not. Looking at the code, I think you can also drop the
>> params=$1 part:
>>
>>   RewriteRule             ^/(.*) /radosgw.fcgi?%{QUERY_STRING}
>> [E=HTTP_AUTHORIZATION:%{HTTP:Authorization},L]
>>
>> >
>> >>> Also, for each of these, where would the logging output end up?
>> >>> /var/log/ceph? Apache error log? If so, only if the Apache LogLevel is
>> >>> more verbose than info? Syslog?
>> >>
>> >>
>> >> The debug log would end up wherever you specified in the 'log file'
>> >> config option.
>> >
>> > ... or syslog, if log file = "" and syslog = true. (iirc)
>>
>> Yeah. Whichever ceph logging scheme you're using.
>>
>> >
>> >>> 6. Swift API: Keys
>> >>>
>> >>> Is it correct to assume that for any Swift client to work, we must set a
>> >>> Swift key for the user, like so?
>> >>>
>> >>> radosgw-admin key create --key-type=swift --uid=<user>
>> >>>
>> >>> If so, is the secret_key that that creates for the user:
>> >>>
>> >>>  "swift_keys": [
>> >>>        { "user": "<user>",
>> >>>          "secret_key": "<longbase64hash>"}]}
>> >>>
>> >>>
>> >>> ... the same key that the swift command line client expects to be set
>> >>> with th -K option?
>> >>
>> >> Yes.
>> >
>> > OK, but I realized that you apparently have to create a separate key
>> > when creating a sub-user. Is that correct? Or is there a way for
>> > sub-users to "inherit" the keys defined for their parent user?
>> >
>> >>> 7. Swift API: swift user name
>> >>>
>> >>> When we call "swift -U <user>", is that the verbatim user_id that we've
>> >>> defined with "radosgw-admin user create --uid=<user_id>"? Or do we need
>> >>> to set a prefix? Or define a separate Swift user ID?
>> >>>
>> >>
>> >> In swift the terminology is a bit different. There is the account and
>> >> under that there is the user. Since we already have a 'user' (which is
>> >> actually the swift account), we created a 'subuser'. So a one liner
>> >> user and swift-subuser creation would be as follows:
>> >>
>> >> # radosgw-admin user create --subuser=yehuda:yehuda1
>> >> --display-name=Yehuda --key-type=swift --access=full
>> >
>> > It seems there is some magic involved so that if you do "user create",
>> > set --subuser=<prefix>:<sub> and don't set --uid, it creates a new
>> > parent user named <prefix>. Is this meant to be stable? Or is the
>>
>> The <user>:<subuser> notation is stable.
>>
>> > supported way of doing things to always first create a user, and then
>> > use "subuser create" to create the subuser?
>>
>> Both are supported, but note that the 'user create' command requires a
>> display-name to be specified, whereas the 'subuser create' doesn't. We
>> can change that later and only require the display-name if the user
>> does not exist, but at the moment that's how it works.
>>
>> >
>> >> { "user_id": "yehuda",
>> >>   "rados_uid": 0,
>> >>   "display_name": "Yehuda",
>> >>   "email": "",
>> >>   "suspended": 0,
>> >>   "max_buckets": 1000,
>> >>   "subusers": [
>> >>         { "id": "yehuda:yehuda1",
>> >>           "permissions": "full-control"}],
>> >>   "keys": [],
>> >>   "swift_keys": [
>> >>         { "user": "yehuda:yehuda1",
>> >>           "secret_key": "7TD5f2QrwxkCnhthwowC4d9uEJ4mnX8nGsXjmnW8"}]}
>> >>
>> >
> Hi Yehuda, Florian,
>
> I follow the wiki, and steps which you discussed,
> construct my ceph system with rados gateway,
> and I can use libs3 to upload file via radosgw, (thanks a lot!)
> but got "405 Method Not Allowed" when I use swift,
>
> $ swift -v -A http://s3.paca.tw:80/auth -U paca:paca1 -K
> UoJO4nFgdAoX+9nEftElIY+AMmDIkcrUBkycNKPA stat
> Auth GET failed: http://s3.paca.tw:80/auth/tokens 405 Method Not Allowed
>
> ( Because there has no test step on wiki,
>  I follow the Florian's question, and guess the test command is above ?!)
>
> my radosgw-admin config:
> $ radosgw-admin user info --uid=paca
> { "user_id": "paca",
>   "rados_uid": 0,
>   "display_name": "chuanyu",
>   "email": "chuanyu@cs.nctu.edu.tw",
>   "suspended": 0,
>   "subusers": [
>         { "id": "paca:paca1",
>           "permissions": "<none>"}],
>   "keys": [
>         { "user": "paca",
>           "access_key": "DS932H4EI9HK7I1CTDNF",
>           "secret_key": "Rn\/5FqHzRPZFN6f9R\/LuTqvG0AYjbHtrurrGydVk"}],
>   "swift_keys": [
>         { "user": "paca:paca1",
>           "secret_key": "UoJO4nFgdAoX+9nEftElIY+AMmDIkcrUBkycNKPA"}]}
>
> ceph.conf:
> [client.radosgw.gateway]
>     host = volume
>     keyring = /etc/ceph/keyring/radosgw.gateway.keyring
>     rgw socket path = /var/run/ceph/rgw.sock
>     log file = ""
>     syslog = true
>     debug rgw = 20
>
> my log:
> http://pastebin.com/rhGhATmv
>

For some reason the swift tool here tries to do a POST on
/auth/tokens. In any case, we don't support that, that's why you're
getting 405. Try to stat a container/object and see if that works for
you. In any case, Florian's answer is correct and you're also getting
bit by issue #2650.

Yehuda
