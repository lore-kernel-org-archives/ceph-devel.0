From: Abhishek Varshney <abhishek.varshney@flipkart.com>
Subject: Re: starting with jewel v10.2.5
Date: Thu, 27 Oct 2016 20:34:43 +0530
Message-ID: <CAP3mxSwFciX_7nH5PP8KcML3irmnoT-thELGrUZMi76bzwCkyg@mail.gmail.com>
References: <5811D09C.9080307@dachary.org> <278431d9-747e-baf6-90f5-8980c992a1c6@suse.cz>
 <5811D546.2050607@dachary.org> <87lgxajayr.fsf@suse.com> <5811F337.7080907@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f175.google.com ([209.85.213.175]:34881 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933120AbcJ0PEp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Oct 2016 11:04:45 -0400
Received: by mail-yb0-f175.google.com with SMTP id d128so20199374ybh.2
        for <ceph-devel@vger.kernel.org>; Thu, 27 Oct 2016 08:04:45 -0700 (PDT)
In-Reply-To: <5811F337.7080907@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Abhishek L <abhishek@suse.com>, Nathan Cutler <ncutler@suse.cz>, Ceph Development <ceph-devel@vger.kernel.org>

If I understand the concerns right, how about doing it the other way round?

a) Create a new branch (say qe-jewel) from jewel whenever the release
is ready for QE testing.
b) The tests can now run on this branch and the release can be
prepared against this.
c) The PRs can continue to be merged to jewel as usual, while the
tests are being done.
d) Remove this branch once release is done, or push all commits from
jewel to qe-jewel whenever next release is ready.

This would require no change to the existing workflow atleast for
developers, and accidental merges to the branch under test can be
completely avoided.

~ Abhishek

On Thu, Oct 27, 2016 at 5:59 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 27/10/2016 13:19, Abhishek L wrote:
>>
>> Loic Dachary writes:
>>
>>> On 27/10/2016 12:19, Nathan Cutler wrote:
>>>> On 10/27/2016 12:02 PM, Loic Dachary wrote:
>>>>> Hi Abhishek & Nathan & Abhishek,
>>>>>
>>>>> Hopefully jewel will start testing with QE tomorrow or early next wee=
k.
>>>>>
>>>>> In the past we kept backporting but we were very careful not to merge=
 anything because the release process is not able to work with a SHA1, it w=
ill create the next jewel release with whatever is at the tip of that branc=
h. This limitation has been there for years and there is little chance that=
 it will be resolved any time soon. It routinely creates frustration when s=
omething is merged by accident and tests have to be run again (or worse: th=
ey are not run and the release is done anyway). It also creates extra work =
for the backporters who need to collect backports that could have been merg=
ed because they passed the tests.
>>>>>
>>>>> Instead, I propose that we backport, test and merge to wip-jewel, as =
if it was the jewel branch, until the release is done. And when it's done w=
e rebase wip-jewel on top of jewel (or we verify that there is no need to r=
ebase), we push all commits from wip-jewel to jewel, we delete the wip-jewe=
l branch and we resume backporting to the jewel branch.
>>>>>
>>>>> In a nutshell it means we have a little extra work:
>>>>>
>>>>> a) re-targeting backports to wip-jewel in each PR (which is now possi=
ble with github)
>>>>> b) pushing wip-jewel to jewel after the release and re-targeting back=
ports to jewel
>>>>>
>>>>> And the benefits are that
>>>>>
>>>>> a) we don't have to stop merging while QE runs tests and the release =
is prepared, which takes a few weeks
>>>>> b) there is no risk of an accidental merge that would break the relea=
se process
>>>>>
>>>>> What do you think ?
>>>>
>>>> I wouldn't say it completely removes the risk of an accidental merge t=
o jewel, but it certainly reduces it :-)
>>
>> +1
>> Let's do it.
>
> Yeah !
>
>>>
>>> :-) One would have to a) open a PR against jewel, b) not be noticed by =
someone from the backport team, c) be merged by someone who is not aware of=
 the new convention. It's indeed not impossible.
>>>
>>>> Anyway, it sounds good to me. The only awkwardness is that it will req=
uire existing backport PRs to be closed and reopened (AFAIK there is no oth=
er way to "retarget" a PR to a different branch).
>>>
>>> It is now possible, when you click "Edit" on the PR title you also have=
 the option to change the target branch of the PR.
>>
>> Nice, other note is for others who may send in PRs at this
>> time for jewel branch, we may need to do this until 10.2.4 is released
>
> True. It's low overhead though and we review every PR to check/add cross =
reference anyway so the burden is not high :-)
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
