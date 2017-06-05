From: John Spray <jspray@redhat.com>
Subject: Re: [sepia] CentOS builds failing in Shaman since Friday evening
Date: Mon, 5 Jun 2017 18:29:49 +0100
Message-ID: <CALe9h7d7p+f2nSkZhdLRWbZyGQUOA07vDiPMOJzDvKRi06hy0Q@mail.gmail.com>
References: <4a0aa923-028a-a9bf-d988-ead0f51fe831@suse.cz> <CAJ4mKGYGn4vL3k5TKs3v=Ho8L7DuU97eDWLD_HBqCKf+J+pfZg@mail.gmail.com>
 <alpine.DEB.2.11.1706032044430.3646@piezo.novalocal> <CALe9h7dXF2LhGvrv-6Y6aKYTJmFTqa1H54Za_S1pUuP=ihmmOA@mail.gmail.com>
 <CAC-Np1w0XQOdRcrqUYstYwZ+b4v_5eGr1jDpBcNicX896C6Z5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37373 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbdFERaL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jun 2017 13:30:11 -0400
Received: by mail-wm0-f41.google.com with SMTP id d73so29864875wma.0
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jun 2017 10:30:11 -0700 (PDT)
In-Reply-To: <CAC-Np1w0XQOdRcrqUYstYwZ+b4v_5eGr1jDpBcNicX896C6Z5Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Sage Weil <sage@newdream.net>, "sepia@ceph.com" <sepia@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>

On Mon, Jun 5, 2017 at 2:16 PM, Alfredo Deza <adeza@redhat.com> wrote:
> On Sun, Jun 4, 2017 at 5:26 AM, John Spray <jspray@redhat.com> wrote:
>> On Sat, Jun 3, 2017 at 9:45 PM, Sage Weil <sage@newdream.net> wrote:
>>> I'm seeing the builds all complete:
>>>
>>> https://shaman.ceph.com/repos/ceph/wip-sage-testing/468be5dab6a2d8421a4fc35744463d47a80f47c2/
>>>
>>> but it won't schedule:
>>>
>>> $ teuthology-suite -s rados -c wip-sage-testing2 --subset 111/444 -p 100
>>> -k distro
>>> 2017-06-03 20:44:27,112.112 INFO:teuthology.suite.run:kernel sha1: distro
>>> 2017-06-03 20:44:27,389.389 INFO:teuthology.suite.run:ceph sha1:
>>> b03f3062d40c35e4898d77604d62e7e7c4e88afd
>>> Traceback (most recent call last):
>>>   File "/home/sage/src/teuthology/virtualenv/bin/teuthology-suite", line 11, in <module>
>>>     load_entry_point('teuthology', 'console_scripts', 'teuthology-suite')()
>>>   File "/home/sage/src/teuthology/scripts/suite.py", line 137, in main
>>>     return teuthology.suite.main(args)
>>>   File "/home/sage/src/teuthology/teuthology/suite/__init__.py", line 86, in main
>>>     run = Run(conf)
>>>   File "/home/sage/src/teuthology/teuthology/suite/run.py", line 46, in __init__
>>>     self.base_config = self.create_initial_config()
>>>   File "/home/sage/src/teuthology/teuthology/suite/run.py", line 92, in create_initial_config
>>>     self.choose_ceph_version(ceph_hash)
>>>   File "/home/sage/src/teuthology/teuthology/suite/run.py", line 185, in choose_ceph_version
>>>     util.schedule_fail(str(exc), self.name)
>>>   File "/home/sage/src/teuthology/teuthology/suite/util.py", line 72, in schedule_fail
>>>     raise ScheduleFailError(message, name)
>>> teuthology.exceptions.ScheduleFailError: Scheduling sage-2017-06-03_20:44:27-rados-wip-sage-testing2-distro-basic-smithi
>>> failed: 'package_manager_version'
>>>
>>> :/
>>
>> Same here.
>
> On Friday we had configuration that was recently pushed to Jenkins to
> build nfs-ganesha and samba for every commit to Ceph release branches
> *including master*
>
> The effect of that change was not immediately apparent since it
> "reacts" to behavior on the Ceph repo.
>
> Locally `git log` just shows 19 new commits for June 2nd (that Friday)
> but Github shows about 15 merges with a *ton* of commits for master
> (+100 commits)
>
> This is not usually a problem, but the combinatorial effect meant that
> those ~100 commits where really more like +300 commits *that appeared
> within minutes of each other*.
>
> Trying to mitigate that problem, I manually tried to change a slave to
> be able to consume more of these "bookkeeping" from the master Jenkins
> instance. This had the problem of
> doing up to 10 ceph builds at the same time (we don't allow this) and
> having mixed information as to where builds go.
>
> Builds follow this path: github -> jenkins trigger -> jenkins jobs for
> different distros -> jenkins asks shaman what chacra server to push to
> -> binaries are pushed to selected chacra server
>
> Since I made this one server do several Ceph builds, the variables
> that are used to find out "what chacra server should I push my
> binaries to" got polluted. This is why John's build POSTed
> to a chacra server that was wrong (hence the 404).
>
> On Friday we disabled the nfs-ganesha, and samba builds, and we have a
> tracker issue open to address the fact that we are (currently) unable
> to digest several hundred commits at once:
>
>     http://tracker.ceph.com/issues/20095
>
> Apologies for the trouble, this unfortunately means you will need to
> rebuild your branches (if they failed to schedule)

Thanks Alfredo -- we appear to be back in business!

John

>
>>
>> The tip of my branch is 50b0654e, I can see teuthology finding that
>> and going to query shaman at this URL:
>> https://shaman.ceph.com/api/search/?status=ready&project=ceph&flavor=default&distros=centos%2F7%2Fx86_64&sha1=50b0654ed19cb083af494878738c7debe80db31e
>>
>> The result has an empty dict for the 'extra' field, where teuthology
>> is expecting to see package_manager_version.
>>
>> That stuff is supposed to be populated by ceph-build/build/build-rpm
>> posting a repo-extra.json file to chacra.ceph.com
>>
>> I see my build log here:
>> https://jenkins.ceph.com/job/ceph-dev-new-build/ARCH=x86_64,AVAILABLE_ARCH=x86_64,AVAILABLE_DIST=centos7,DIST=centos7,MACHINE_SIZE=huge/3848//consoleFull
>>
>> And I see the POST to chacra failing here:
>>
>> """
>> build@2/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/repo-extra.json
>> -u admin:[*******]
>> https://1.chacra.ceph.com/repos/ceph/wip-jcsp-testing-20170604/50b0654ed19cb083af494878738c7debe80db31e/centos/7/flavors/default/extra/
>>   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
>>                                  Dload  Upload   Total   Spent    Left  Speed
>>
>>   0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
>> 100   505  100    52  100   453    145   1267 --:--:-- --:--:-- --:--:--  1268
>> 404 Not Found
>>
>> The resource could not be found.
>> """
>>
>> So the ceph-build script is succeeding where it should be failing
>> (does curl not return an error or is the script ignoring it?) and
>> something is wrong with chacra.ceph.com that's making it 404 here (I
>> don't know where to begin to debug that).
>>
>> John
>>
>> P.S. Probably a topic for another day, but I didn't love having to
>> traverse several different git repos to try and work out what was
>> happening during a build, wouldn't it be simpler to have a single repo
>> for the build infrastructure?
>>
>>>
>>> On Sat, 3 Jun 2017, Gregory Farnum wrote:
>>>
>>>> Adding sepia list for more infrastructure dev attention. (No idea where that
>>>> problem is coming from.)
>>>>
>>>> On Sat, Jun 3, 2017 at 5:52 AM Nathan Cutler <ncutler@suse.cz> wrote:
>>>>       CentOS builds in Shaman started failing with this error:
>>>>
>>>>       {standard input}: Assembler messages:
>>>>       {standard input}:186778: Warning: end of file not at end of a
>>>>       line;
>>>>       newline inserted
>>>>       {standard input}: Error: open CFI at the end of file; missing
>>>>       .cfi_endproc directive
>>>>       c++: internal compiler error: Killed (program cc1plus)
>>>>       Please submit a full bug report,
>>>>       with preprocessed source if appropriate.
>>>>       See <http://bugzilla.redhat.com/bugzilla> for instructions.
>>>>
>>>>       AFAICT the first occurrence was in [1] and the error has been
>>>>       haunting
>>>>       the build queue since then.
>>>>
>>>>       [1]
>>>> https://shaman.ceph.com/builds/ceph/wip-sage-testing2/f93ad23a8fec219667a03
>>>>       695136842edb0cceace/default/45729/
>>>>
>>>>       Nathan
>>>>       --
>>>>       To unsubscribe from this list: send the line "unsubscribe
>>>>       ceph-devel" in
>>>>       the body of a message to majordomo@vger.kernel.org
>>>>       More majordomo info at
>>>>       http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>>>
>>>
>>> _______________________________________________
>>> Sepia mailing list
>>> Sepia@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/sepia-ceph.com
>>>
>> _______________________________________________
>> Sepia mailing list
>> Sepia@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/sepia-ceph.com
