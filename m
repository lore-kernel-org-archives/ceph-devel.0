From: =?UTF-8?B?THVpcyBQYWLDs24=?= <lpabon@redhat.com>
Subject: Re: RGW Swift questions
Date: Thu, 14 Aug 2014 12:52:50 -0400
Message-ID: <53ECE962.8090208@redhat.com>
References: <53ECC736.2090202@redhat.com>	<CABBk=J9KxxYNeZNTpLbRRNbd0ApqdSojbh-f3R7iuuF=FvfoGQ@mail.gmail.com>	<368555473.7277905.1408032020541.JavaMail.zimbra@redhat.com> <CABBk=J94xz+0oCcnoq-EnFXNrPYCrgkv3zw2-O7Aa19+z+egMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60634 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194AbaHNQww (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Aug 2014 12:52:52 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7EGqpVh032675
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <ceph-devel@vger.kernel.org>; Thu, 14 Aug 2014 12:52:51 -0400
In-Reply-To: <CABBk=J94xz+0oCcnoq-EnFXNrPYCrgkv3zw2-O7Aa19+z+egMw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Great thanks!

- Luis

On 08/14/2014 12:40 PM, Yehuda Sadeh wrote:
> On Thu, Aug 14, 2014 at 9:00 AM, Luis Pabon <lpabon@redhat.com> wrote=
:
>> Thanks for the quick turnaround Yehuda.  I have just a few more comm=
ents below:
>>
>> ----- Original Message -----
>> From: "Yehuda Sadeh" <yehuda@redhat.com>
>> To: "Luis Pab=C3=B3n" <lpabon@redhat.com>
>> Cc: ceph-devel@vger.kernel.org
>> Sent: Thursday, August 14, 2014 11:02:06 AM
>> Subject: Re: RGW Swift questions
>>
>> On Thu, Aug 14, 2014 at 7:27 AM, Luis Pab=C3=B3n <lpabon@redhat.com>=
 wrote:
>>> Hi Yehuda,
>>>      I am starting work on RGW and have a few questions:
>>>
>>> * Why is the command 'user create' when I am sending '--subuser'. S=
eems
>>> confusing.  Is there a reason why we are not to use 'subuser create=
'?
>> A subuser needs to have the containing user in order to be created.
>> The 'user create' command generates ones. The order of things would =
be
>> to create a user, then create a subuser for that user. By specifying
>> --subuser=3D.. on the user creation it should do both.
>>
>> [LP] Great, thank you
>>
>>> * If I use "user create --subuser", the JSON returned shows the ent=
ry for
>>> "subusers" is empty.  What is subusers for? (This is related to the=
 previous
>>> question)
>> So I assume the subuser wasn't created?
>> The rgw user model follows the S3 user model which is a bit differen=
t
>> from the swift one. In S3 there's basically a single tenant, multipl=
e
>> users. With swift there are multiple tenants (originally referred to
>> as 'accounts'), each have different users that share a similar view =
of
>> the system (e.g., share list of containers, etc.). The more natural
>> (although not perfect) mapping is by having an rgw user map to a swi=
ft
>> account. That's why we needed to add a second level of identificatio=
n,
>> the subuser.
>>
>> [LP] I will have to check why it is empty.
>>
>>
>>> * Where do I place the OpenStack Tenant information?
>> The tenant id should be the user name.
>>
>> [LP] Cool, thanks. So if the tenant is the user name in RGW, what is=
 the Swift user
>> map to?
> It maps into the subuser.
>
> Yehuda
>
>>> * Is there a document which describes how to setup RGW for OpenStac=
k Swift?
>> Not that I'm aware of. Basically rgw is set to work with both S3 and
>> Swift out of the box. Here's how to integrate with keystone:
>> http://ceph.com/docs/master/radosgw/keystone/
>>
>>> * The radosgw-admin help screen does not explain which options to u=
se for
>>> certain commands.  Is this something that we should fix?
>> We should certainly improve documentation. This can either go into t=
he
>> man page, or a complete rework of the usage help.
>>
>>> * On page: http://ceph.com/docs/master/radosgw/swift/auth/ , clicki=
ng on
>>> "see radosgw-admin" does not work.
>> I opened issue #9116.
>>
>>
>> Thanks,
>> Yehuda
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
