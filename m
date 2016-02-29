From: Abhishek Varshney <abhishek.varshney@flipkart.com>
Subject: Re: (Un)Stable release team
Date: Mon, 29 Feb 2016 18:16:07 +0530
Message-ID: <CAP3mxSy+VODD72z0LtZ0iJ5YMDqAnLOtV3p460yg9_QuW63Q2g@mail.gmail.com>
References: <56D001C6.5080804@dachary.org>
	<CAP3mxSwfM+z_p=ppFUxB-6M8w_u_tty8Yu1uv=+UN1MonQ_m4A@mail.gmail.com>
	<56D3F913.8020008@dachary.org>
	<56D42F0B.9050304@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34805 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbcB2MqJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Feb 2016 07:46:09 -0500
Received: by mail-lb0-f181.google.com with SMTP id of3so78986359lbc.1
        for <ceph-devel@vger.kernel.org>; Mon, 29 Feb 2016 04:46:08 -0800 (PST)
In-Reply-To: <56D42F0B.9050304@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Nathan Cutler <ncutler@suse.cz>, Abhishek L <abhishek.lekshmanan@gmail.com>, "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Gaurav Bafna <bafnag@gmail.com>, Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>, Martin Palma <martin@palma.bz>, Chris Jones <cjones@cloudm2.com>, M Ranga Swami Reddy <swamireddy@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

On Mon, Feb 29, 2016 at 5:14 PM, Loic Dachary <loic@dachary.org> wrote:
> To quickly summarize the discussion on IRC, should we decide to go fo=
r improving paddles, it would probably make sense to:
>
> * Implement a mirror feature in paddles. A new paddle could query an =
existing paddle and update its database with what it finds there. The i=
ssue / comment fields would only be allowed on completed runs which are=
 immutable in the existing paddles and do not cause problems with syncr=
honization.
> * A centralized paddles read/write to the public would mirror informa=
tion from the paddles that are used by http://pulpito.ceph.com/ and htt=
p://pulpito.ovh.sepia.ceph.com:8081/
> * A pulpito would run from this centralized paddles and implement new=
 features, with no risk to disrupt the existing paddles/pulpito, which =
would be a good testbed to demonstrate pull requests implementing these=
 new features can be accepted
> * teuthology-openstack ( or ceph-workbench ceph-qa-suite ) would have=
 a new --paddles options to use this centralized paddles server instead=
 of creating a new one, so that results are archived in a permanent pla=
ce (that would be the default).

This looks good to me. This would mean that paddles+pulpito would
eventually evolve into more interactive tool :)
>
> On 29/02/2016 14:53, Loic Dachary wrote:
>> Hi,
>>
>> This week-end I updated http://ceph-workbench.dachary.org/root/ceph-=
workbench and got the integration tests to pass again (a few minor issu=
es broke it in the past two months http://ceph-workbench.dachary.org/ro=
ot/ceph-workbench/activity). I suppose the most important item in the b=
acklog is to have a convenient way to record the teuthology runs and as=
sociate them with known issues. I updated http://ceph-workbench.dachary=
=2Eorg/root/ceph-workbench/issues/26 with a short description of what i=
t would look like if we used the redmine wiki for that purpose. But it =
feels fragile and redundant with paddles (the database that records the=
 tests).
>>
>> I think we have three options to automate the use case we want (i.e.=
 what we've been doing at http://tracker.ceph.com/issues/14692 & al).
>>
>> * Automate the redmine update using issue comments & wiki pages (htt=
p://ceph-workbench.dachary.org/root/ceph-workbench/issues/26).
>> * Create a git-notes database with links to issues / pr / test resul=
ts (http://ceph-workbench.dachary.org/root/ceph-workbench/issues/5)
>> * Improve paddles / pulpito
>>
>> We've discussed the first two options extensively over the past year=
 but not so much the idea of improving paddles / pulpito. Maybe because=
 pulpito is too much web and not enough plain text for my taste, at lea=
st that's one of the things that comes to mind. But this can probably b=
e improved as well. It could go
>> like this:
>>
>> * Add an "issue" and "comment" field in paddles for each test.
>> * Add a query to show all jobs that ran against a given SHA1 to padd=
les (that's the focus we have in the stable release issues)
>> * Add a query to show all run of a given job (based on the descripti=
on) to paddles
>> * Add a redmine friendly text output to pulpito so that it can be co=
py/pasted to a comment (instead of doing what we do with the fail.py sc=
ript and maybe more)
>> * Add the input fields in pulpito to fill the "issue" field and the =
"comment" field to the pulpito UI (which is what we do when analyzing f=
ailures).
>>
>> What do you think ?
>>
>> Cheers
>>
>> On 26/02/2016 15:12, Abhishek Varshney wrote:
>>> Hi Loic,
>>>
>>> On Fri, Feb 26, 2016 at 1:11 PM, Loic Dachary <loic@dachary.org> wr=
ote:
>>>> Hi,
>>>>
>>>> It's a quiet time in the small world of the stable release team, i=
deal for mentoring the new members who generously answered our call for=
 participation. Welcome to Chen Xiaoxi, Gaurav Bafna, Wei-Chung Cheng, =
Martin Palma and Chris Jones :-)
>>>>
>>>> I propose that we take advantage of the next few weeks to expand o=
ur scope in two ways:
>>>>
>>>> * test Ceph development versions as well as stable versions
>>>> * publish packages for Ceph development versions
>>>>
>>>> Testing Ceph development versions is actually less work than with =
stable versions because the developers run a lot of tests already and f=
ix problems on a daily basis. Our help would likely be needed with a fe=
w teuthology suite runs right before the development release is publish=
ed, once a month. But the development versions tend to be more frequent=
, therefore it will probably be as much work as for a stable release, o=
verall. The workflow would be revisited: there is no cherry-picking. In=
stead, bug fixes must be against the jewel branch or whatever branch wi=
ll be the upcoming stable. And this branch is merged back into master o=
n a regular basis (i.e. more frequently than the development releases).
>>>>
>>>> As you may have noticed, no packages were published for the 10.0.3=
 development release and that's where we could make a real difference. =
This would be an entirely new part of our workflow, but also an excitin=
g one because it's the last missing piece of the puzzle. Once we are ab=
le to publish usable packages for development releases, nothing is stop=
ping us to do the same for stable releases. It's a lot easier than it s=
eems since the packages are already built for the teuthology jobs. All =
we need is a public space to archive them and sign them. This is not mu=
tually exclusive with the current package publication workflow, it woul=
d be a community driven alternative that is much needed in some cases.
>>>>
>>>> Of course, this is easier said than done :-) What do you think ? A=
re there other important work that we should try to accomplish instead =
? Things that would benefit Ceph users and developers more ?
>>>
>>> Would it be a good idea to give some focus to ceph-workbench[1] too
>>> and formalise backport workflows, since we have a bigger Stable
>>> Releases Team now?
>>>
>>> [1] https://pypi.python.org/pypi/ceph-workbench
>>>
>>>>
>>>> Cheers
>>>>
>>>> --
>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>>> Thanks
>>> Abhishek
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
