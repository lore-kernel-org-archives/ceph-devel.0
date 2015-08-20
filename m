From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: hammer integration tests for v0.94.4
Date: Thu, 20 Aug 2015 21:15:48 +0530
Message-ID: <CAEw75dObNbD3XNBYqr7SjZWz7cRHGe6B+43==m1PjZ-WY2SDPQ@mail.gmail.com>
References: <CAP3mxSw7B0HA7iTB+Fr8sF3bxL2V2KKoq7LdWER9kuVr_XZ4FQ@mail.gmail.com>
	<55D4AD0F.1080908@dachary.org>
	<CAP3mxSyyXwpJL8VFrsGZ6E7Bdckh1gLTi33PzeNdG8AccxrYKg@mail.gmail.com>
	<55D5D699.7000005@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35292 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbbHTPpt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Aug 2015 11:45:49 -0400
Received: by igbjg10 with SMTP id jg10so131692450igb.0
        for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2015 08:45:48 -0700 (PDT)
In-Reply-To: <55D5D699.7000005@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Abhishek Varshney <abhishek.varshney@flipkart.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Aug 20, 2015 at 7:01 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 20/08/2015 08:42, Abhishek Varshney wrote:
>> Hi Loic,
>>
>> I see that the failures in rgw suite are either related to s3 or swi=
ft clients. Out of all the PRs merged in this backports branch which ar=
e related to rgw, the PR that I backported ( https://github.com/ceph/ce=
ph/pull/5482 and https://github.com/ceph/ceph/pull/5496 ) look like can=
didates for these failures?

The S3 errors seem to be similiar to a radosgw-agent failure reported
on master as well. This is the issue
http://tracker.ceph.com/issues/12661. Havent figured out the swift fail=
ures yet.
>
> I'm not sure... Abhishek Lekshmanan knows more than I do about rgw.
>
>> Thanks
>> Abhishek
>>
>> On Wed, Aug 19, 2015 at 9:51 PM, Loic Dachary <loic@dachary.org <mai=
lto:loic@dachary.org>> wrote:
>>
>>     Hi Abhishek,
>>
>>     The tests for your integration branch completed and I updated ht=
tp://tracker.ceph.com/issues/12701#teuthology-run-commit-e1dadd3da9e39d=
af669f94715c7833d2b280bbed-HAMMER-BACKPORTS-August-14 to reflect the re=
sults.
>>
>>     The general idea is that if there are a few failed jobs, I just =
re-scheduled them assuming this is noise (fs, rados, rbd). The rgw suit=
e however had a number of failures and I just updated http://tracker.ce=
ph.com/issues/12701#rgw to group the same error together. There seems t=
o be only two types of error.
>>
>>     Can you make sense of them ?
>>
>>     Cheers
>>
>>     On 19/08/2015 17:37, Abhishek Varshney wrote:
>>     > Hey Loic,
>>     >
>>     > I saw that there was a PR which was probably causing all the u=
pgrade tests to hang. What about other tests which failed in other suit=
es?
>>     >
>>     > Also let me know how should I proceed now or any other task th=
at I can take?
>>     >
>>     > Thanks
>>     > Abhishek
>>     >
>>     > --------------------------------------------------------------=
-----------------------------------------------------------------------=
-----
>>     >
>>     > This email and any files transmitted with it are confidential =
and intended solely for the use of the individual or entity to whom the=
y are addressed. If you have received this email in error please notify=
 the system manager. This message contains confidential information and=
 is intended only for the individual named. If you are not the named ad=
dressee you should not disseminate, distribute or copy this e-mail. Ple=
ase notify the sender immediately by e-mail if you have received this e=
-mail by mistake and delete this e-mail from your system. If you are no=
t the intended recipient you are notified that disclosing, copying, dis=
tributing or taking any action in reliance on the contents of this info=
rmation is strictly prohibited. Although Flipkart has taken reasonable =
precautions to ensure no viruses are present in this email, the company=
 cannot accept responsibility for any loss or damage arising from the u=
se of this email or attachments
>>     >
>>
>>     --
>>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>>
>>
>> --------------------------------------------------------------------=
----------------------------------------------------------------------
>>
>> This email and any files transmitted with it are confidential and in=
tended solely for the use of the individual or entity to whom they are =
addressed. If you have received this email in error please notify the s=
ystem manager. This message contains confidential information and is in=
tended only for the individual named. If you are not the named addresse=
e you should not disseminate, distribute or copy this e-mail. Please no=
tify the sender immediately by e-mail if you have received this e-mail =
by mistake and delete this e-mail from your system. If you are not the =
intended recipient you are notified that disclosing, copying, distribut=
ing or taking any action in reliance on the contents of this informatio=
n is strictly prohibited. Although Flipkart has taken reasonable precau=
tions to ensure no viruses are present in this email, the company canno=
t accept responsibility for any loss or damage arising from the use of =
this email or attachments
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
