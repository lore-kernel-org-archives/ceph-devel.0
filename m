From: Samuel Just <sam.just@inktank.com>
Subject: Re: upcoming release giant v0.87.1 : leads feedback needed
Date: Fri, 16 Jan 2015 13:34:45 -0800
Message-ID: <CA+4uBUaRgPzODMqzUsDNX96g60ijbP3wFh_C4vJcoU4jnpeMxQ@mail.gmail.com>
References: <54B7E6DC.8010905@dachary.org>
	<54B7F2DF.9060003@dachary.org>
	<54B975DE.3020504@dachary.org>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:37618 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbbAPVer convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jan 2015 16:34:47 -0500
Received: by mail-la0-f46.google.com with SMTP id s18so329185lam.5
        for <ceph-devel@vger.kernel.org>; Fri, 16 Jan 2015 13:34:45 -0800 (PST)
In-Reply-To: <54B975DE.3020504@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Some of the rados errors look concerning, I'll have a look.
-Sam

On Fri, Jan 16, 2015 at 12:34 PM, Loic Dachary <loic@dachary.org> wrote=
:
> Hi Again,
>
> As it turns out we're going to have giant point releases after all. I=
n a nutshell there is going to be one or two point release for giant, u=
ntil Hammer is out. The backporting activity for giant will be lower th=
an for firefly or hammer, because the idea is to focus on backporting e=
very other release (i.e. dumpling, firefly, hammer, etc. ).
>
> My initial request is therefore resumed and the ticket open again.
>
> Thanks for your patience and sorry for the confusion :-)
>
> On 15/01/2015 18:03, Loic Dachary wrote:
>> Hi Again,
>>
>> Well, this is a little embarassing but here it is : there won't be a=
 point release for giant. I'll update the redmine tickets to remove the=
 "giant" backport targets as well as the github milestone list accordin=
gly.
>>
>> Sorry for the noise.
>>
>> On 15/01/2015 17:12, Loic Dachary wrote:
>>> Hi Ceph,
>>>
>>> The https://github.com/ceph/ceph/tree/giant-backports branch was te=
sted with the rgw, rados and rbd suites. The results of each suite have=
 been analyzed and summarized in http://tracker.ceph.com/issues/10501. =
The next steps are either:
>>>
>>> a) Yehuda for rgw, Josh for rbd and Sam for rados all agree that th=
e errors are unrelated to the backports
>>> b) The https://github.com/ceph/ceph/tree/giant-backports branch is =
given to QE for final tests and merge into giant
>>>
>>> OR
>>>
>>> a) At least of the lead thinks more work is needed to stabilize the=
 giant branch
>>> b) A new set of tests will be run and analyzed after adding/removin=
g one or more backports to/from the https://github.com/ceph/ceph/tree/g=
iant-backports branch
>>>
>>> The description of http://tracker.ceph.com/issues/10501 shows a det=
ailed list of all commits / issues that are in the giant backport branc=
h. To get a global view of what the next giant point release will be, t=
he description also includes the commits that have already been merged =
in the giant branch. The list of pull requests that are candidate for i=
nclusion in the giant release but have not been included in the integra=
tion branch are also listed: maybe one of them could contribute to reso=
lve a problem found during the tests. And finally all redmine issues th=
at have been marked to be backported to giant but do not yet have a can=
didate pull request are listed: this is the backport backlog so to spea=
k ;-)
>>>
>>> Cheers
>>>
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
