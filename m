From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: [ceph-users] Ceph.conf
Date: Thu, 10 Sep 2015 05:57:45 -0400 (EDT)
Message-ID: <518147335.14834792.1441879065903.JavaMail.zimbra@redhat.com>
References: <719445511.14807548.1441873777873.JavaMail.zimbra@redhat.com> <945773049.14811634.1441874647066.JavaMail.zimbra@redhat.com> <CAJ4mKGbF1zME=hQxjk5SOxqxnYDxPeJZgsZ=Sf3m=TNW-9e=eg@mail.gmail.com> <1048259835.14823145.1441876904812.JavaMail.zimbra@redhat.com> <CAEw75dMj3HZXxnpjPZAH2CLA=C3LRPm1wU9gmPdf-cOLq-dwTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:49440 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbbIJJ5r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Sep 2015 05:57:47 -0400
In-Reply-To: <CAEw75dMj3HZXxnpjPZAH2CLA=C3LRPm1wU9gmPdf-cOLq-dwTg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Thank you for letting me know your thought, Abhishek!!


    > The Ceph Object Gateway will query Keystone periodically
    > for a list of revoked tokens. These requests are encoded
    > and signed. Also, Keystone may be configured to provide 
    > self-signed tokens, which are also encoded and signed.


This is completely absolutely out of scope of my original
question.

But I would like to ask you if above implementation that
**periodically** talks to keystone with tokens is really
secure or not.

I'm just asking you. Because I'm just thinking of keysto-
ne federation.

But you can ignore me anyhow or point out anything to me -;

Shinobu

----- Original Message -----
From: "Abhishek L" <abhishek.lekshmanan@gmail.com>
To: "Shinobu Kinjo" <skinjo@redhat.com>
Cc: "Gregory Farnum" <gfarnum@redhat.com>, "ceph-users" <ceph-users@lists.ceph.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
Sent: Thursday, September 10, 2015 6:35:31 PM
Subject: Re: [ceph-users] Ceph.conf

On Thu, Sep 10, 2015 at 2:51 PM, Shinobu Kinjo <skinjo@redhat.com> wrote:
> Thank you for your really really quick reply, Greg.
>
>  > Yes. A bunch shouldn't ever be set by users.
>
>  Anyhow, this is one of my biggest concern right now -;
>
>     rgw_keystone_admin_password =
>                        ^^^^^^^^
>
> MUST not be there.


I know the dangers of this (ie keystone admin password being visible);
but isn't this already visible in ceph/radosgw configuration file as
well if you configure keystone.[1]

[1]: http://ceph.com/docs/master/radosgw/keystone/#integrating-with-openstack-keystone

> Shinobu
>
> ----- Original Message -----
> From: "Gregory Farnum" <gfarnum@redhat.com>
> To: "Shinobu Kinjo" <skinjo@redhat.com>
> Cc: "ceph-users" <ceph-users@lists.ceph.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Thursday, September 10, 2015 5:57:52 PM
> Subject: Re: [ceph-users] Ceph.conf
>
> On Thu, Sep 10, 2015 at 9:44 AM, Shinobu Kinjo <skinjo@redhat.com> wrote:
>> Hello,
>>
>> I'm seeing 859 parameters in the output of:
>>
>>     $ ./ceph --show-config | wc -l
>>     *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
>>     859
>>
>> In:
>>
>>     $ ./ceph --version
>>     *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
>>     ceph version 9.0.2-1454-g050e1c5 (050e1c5c7471f8f237d9fa119af98c1efa9a8479)
>>
>> Since I'm quite new to Ceph, so my question is:
>>
>>     Where can I know what each parameter exactly mean?
>>
>> I am probably right. Some parameters are just for tes-
>> ting purpose.
>
> Yes. A bunch shouldn't ever be set by users. A lot of the ones that
> should be are described as part of various operations in
> ceph.com/docs, but I don't know which ones of interest are missing
> from there. It's not very discoverable right now, unfortunately.
> -Greg
>
>>
>> Thank you for your help in advance.
>>
>> Shinobu
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
