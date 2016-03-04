From: Martin Palma <martin@palma.bz>
Subject: Re: CentOS 6 and Ubuntu Precise binaries for Hammer 0.94.6
Date: Fri, 4 Mar 2016 08:56:57 +0100
Message-ID: <CANMxC7D+d5DqNV7HTduOk8p0z-W0X0ZfoonKxgLTWAQ8rtSv8g@mail.gmail.com>
References: <CAC-Np1xgn8TsowLqrtkRjjLYbmpmy1dk2NuG3v+uDpm4AVHJRg@mail.gmail.com>
 <CANMxC7CEj+NO-YE8HZbfLg6zaqgjz+0zLCgaCSt+DyH_mEjY0Q@mail.gmail.com>
 <CAC-Np1wC6BQ8j9+XZWXBsWe_cTRUd1w+Dv9s5tzHznjmRWRB2w@mail.gmail.com> <CAC-Np1zne7yWTrh3uA_S9iEiAfs7s7x6Edu7CE7dqvx0NT3yAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36664 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbcCDH5S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2016 02:57:18 -0500
Received: by mail-wm0-f48.google.com with SMTP id n186so22714018wmn.1
        for <ceph-devel@vger.kernel.org>; Thu, 03 Mar 2016 23:57:17 -0800 (PST)
In-Reply-To: <CAC-Np1zne7yWTrh3uA_S9iEiAfs7s7x6Edu7CE7dqvx0NT3yAQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

For me this seems hat the java version 1.6 is already installed and we
have to set the default java version. Here [0] is a PR which does that
for ubuntu precise. I tested this in a simple vagrant vm and worked
there. Could you verify that on your infrastructure this fixes the
issue.

Best,
Martin


[0] https://github.com/ceph/ceph-build/pull/333

(Reposting to the mailing list since my first replay got rejected
because of formatting.)

On Thu, Mar 3, 2016 at 10:52 PM, Alfredo Deza <adeza@redhat.com> wrote:
> This is as far as I got, something is odd here:
>
> admin@precise-test-adeza:~$ sudo apt-get install openjdk-7-jre
> Reading package lists... Done
> Building dependency tree
> Reading state information... Done
> openjdk-7-jre is already the newest version.
> 0 upgraded, 0 newly installed, 0 to remove and 67 not upgraded.
> admin@precise-test-adeza:~$ java -version
> java version "1.6.0_38"
> OpenJDK Runtime Environment (IcedTea6 1.13.10) (6b38-1.13.10-0ubuntu0.12.04.1)
> OpenJDK 64-Bit Server VM (build 23.25-b01, mixed mode)
>
> So probably the wrong package? Again, I think the solution is to apply
> this to a precise box and find out what is the missing link :)
>
> On Thu, Mar 3, 2016 at 4:46 PM, Alfredo Deza <adeza@redhat.com> wrote:
>> On Thu, Mar 3, 2016 at 3:47 PM, Martin Palma <martin@palma.bz> wrote:
>>> Hi Alfredo,
>>>
>>> What Java version is needed? From the "slave" playbook I see that both (yum
>>> and apt based systems) get the same java version (7) installed, so it seems
>>> strange that the Precise build fail.
>>>
>>
>> For some reason it seems that even though it was installed the Java
>> version reported doesn't comply:
>>
>>   [03/03/16 19:07:20] [SSH] Checking java version of java
>>   [03/03/16 19:07:20] [SSH] java -version returned 1.6.0_38.
>>   [03/03/16 19:07:20] [SSH] Starting sftp client.
>>   [03/03/16 19:07:20] [SSH] Copying latest slave.jar...
>>   [03/03/16 19:07:20] [SSH] Copied 506,667 bytes.
>>   Expanded the channel window size to 4MB
>>   [03/03/16 19:07:20] [SSH] Starting slave process: cd
>> "/home/jenkins-build/build" && java  -jar slave.jar
>>
>> The full logs are here: http://dpaste.com/3VX89V8
>>
>> I *believe* that something in the playbook is preventing it to get to
>> install the java package correctly, hence the problem.
>>
>> This will require running the playbook against a precise box and
>> seeing where it fails/stops
>>
>>
>>
>>> Best,
>>> Martin
>>>
>>> On Thu, Mar 3, 2016 at 8:41 PM, Alfredo Deza <adeza@redhat.com> wrote:
>>>>
>>>> Hi All,
>>>>
>>>> Some good news, we were able to go back and get CentOS 6 binaries
>>>> built for the 0.94.6 release.
>>>>
>>>> They aren't published yet (they remain unsigned, queued up in our
>>>> release process).
>>>>
>>>> However, we are at an impasse with the Precise build. We can't get
>>>> Precise nodes to build because the distro has a very old version of
>>>> the JVM which causes issues when connecting to Jenkins as a node.
>>>>
>>>> The exact error when attempting a connection is:
>>>>
>>>>      Caused by: java.lang.UnsupportedClassVersionError:
>>>> hudson/slaves/SlaveComputer$SlaveVersion: Unsupported major.minor 51.0
>>>>
>>>> The way we get a new node for the build system up and running is by
>>>> making an API call to an OpenStack provider that a boot time it runs
>>>> some Ansible playbook which allows the new host to comply with our
>>>> needs to be a workable node and register itself to the Master Jenkins
>>>> server.
>>>>
>>>> What does this mean? --> I can't commit to fix this and would love to
>>>> have some help from anyone in the community. I can review/merge a pull
>>>> request with a patch to the playbook we use to setup slaves so that if
>>>> a Precise machine is used it gets a newer JVM version.
>>>>
>>>> The Github project for our build system is:
>>>> https://github.com/ceph/ceph-build
>>>>
>>>> The YAML file we use to setup new slaves is:
>>>> https://github.com/ceph/ceph-build/blob/master/ansible/slave.yml
>>>>
>>>> Once a fix is in place I can go and get the process going again,
>>>> complete the signing of the binaries and get them released into the
>>>> Hammer repositories.
>>>>
>>>> Thanks
>>>>
>>>>
>>>> Alfredo
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
