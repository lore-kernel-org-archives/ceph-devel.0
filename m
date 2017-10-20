From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: Huge lookup when recursively mkdir
Date: Sat, 21 Oct 2017 02:09:41 +0800
Message-ID: <CAEYCsV+Xf0iZRwHv--1rf8U=D_izp8s5s9W75fc6k_MinJWDWg@mail.gmail.com>
References: <CAEYCsVLCS5aPC8M8PAU5UTS0pKzhp1aWBW6L72ZwvUEetbstpw@mail.gmail.com>
 <CAAM7YAk2+ekeYdJ_E4d5wB_SoiL_eGA0P9fGuxvEkz3r11ytTQ@mail.gmail.com>
 <CAEYCsVL=bcaQY6SBQ=ujR9EEvK3FgUf38s+Bj5UU2Z8SjoPQtA@mail.gmail.com>
 <CAAM7YAn9hFCHTQZ62soWBhBbtmKjw-UCxHqYOCe5m587nfugAw@mail.gmail.com> <CAEYCsVLaC14wBQuD0xE9gs53v7ztPdQ-ac_Vh5F5DD02PHYwQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:51551 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdJTSJn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Oct 2017 14:09:43 -0400
Received: by mail-io0-f177.google.com with SMTP id b186so14117594iof.8
        for <ceph-devel@vger.kernel.org>; Fri, 20 Oct 2017 11:09:42 -0700 (PDT)
In-Reply-To: <CAEYCsVLaC14wBQuD0xE9gs53v7ztPdQ-ac_Vh5F5DD02PHYwQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, John Spray <jspray@redhat.com>

@Zheng, my kernel doesn't even has c3f4688a08f.   But 200fd27 ("ceph:
use lookup request to revalidate dentry") is there.

2017-10-21 0:54 GMT+08:00 Xiaoxi Chen <superdebuger@gmail.com>:
> Thanks, will check.
>
> A general question, does cephfs kernel client drop dentries/inode
> cache aggressively?   What I know is if MDS issue
> CEPH_SESSION_RECALL_STATE, client will drop, but is there other cases
> client will drop cache?
>
>
>
> 2017-10-20 16:39 GMT+08:00 Yan, Zheng <ukernel@gmail.com>:
>> On Fri, Oct 20, 2017 at 3:28 PM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
>>> Centos 7.3, kernel version 3.10.0-514.26.2.el7.x86_64.
>>>
>>> I extract the logical of file creation in our workload into a
>>> reproducer , like below.
>>>
>>> Concurrently run the reproducer in 2+ node can see a lots of lookup OP.
>>> I thought the lookup is to open the directory tree so I tried to
>>> pre-make most of the dirs ,  use ls -i trying to read the dentries and
>>> cache it, then re-run the reproducer,  seems nothing different..
>>>
>>> #include <sys/stat.h>
>>> #include <fcntl.h>
>>> int create_file(char * base, int count, int max, int depth)
>>> {
>>>     int i;
>>>     for(i=0; i<count; i++) {
>>>         char dir[256];
>>>         int mydir = rand() % max;
>>>         sprintf(dir, "%s/%d", path, mydir);
>>>         if (depth >=1) {
>>>             mkdir(dir,0777);
>>>             create_dir(dir, count, max, depth - 1);
>>>         } else {
>>>             int fd = open(dir, O_CREAT | O_EXCL| O_WRONLY , 0666);
>>>             printf("opened path : %s = %d\n", path, fd);
>>>             close(fd);
>>>         }
>>>     }
>>> }
>>> int main(int argc, char argv[])
>>> {
>>>     char path[256];
>>>     while(1) {
>>>       create_file("/import/SQL01", 1, 4 ,10);
>>>     }
>>> }
>>>
>>
>> still don't see this behavior on 4.13 kernel. I suspect there is
>> something wrong with dentry lease. please check if your kernel
>> include:
>>
>> commit c3f4688a08f (ceph: don't set req->r_locked_dir in ceph_d_revalidate)
>> commit 5eb9f6040f3 (ceph: do a LOOKUP in d_revalidate instead of GETATTR)
>>
>> The first commit can cause this issue, the second one fixes it.
>>
>> Regards
>> Yan, Zheng
>>
>>>
>>>
>>> 2017-10-20 10:55 GMT+08:00 Yan, Zheng <ukernel@gmail.com>:
>>>> On Fri, Oct 20, 2017 at 12:49 AM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
>>>>> Hi,
>>>>>
>>>>>       I am seeing a lot of lookup request when doing recursive mkdir.
>>>>>       The workload behavior is like:
>>>>>           mkdir DIR0
>>>>>           mkdir DIR0/DIR1
>>>>>           mkdir DIR0/DIR1/DIR2
>>>>>           ....
>>>>>           mkdir DIR0/DIR1/DIR2......./DIR7
>>>>>           create DIR0/DIR1/DIR2......./DIR7/FILE1
>>>>>
>>>>>       and concurrently run on 50+ clients, the dir name in different
>>>>> clients may or maynot be the same.
>>>>>
>>>>>        from the admin socket I was seeing ~50K create requests, but
>>>>> got 400K lookup requests. The lookup eat up most of the mds capability
>>>>> so file create is slow.
>>>>>
>>>>>        Where is the lookup comes from and can we have anyway to
>>>>> optimize it out ?
>>>>>
>>>>
>>>> I don't see this behavior when running following commands in 4.13
>>>> kernel client and luminous version ceph-fuse. which client do you use?
>>>>
>>>> mkdir d1
>>>> mkdir d1/d2
>>>> mkdir d1/d2/d3
>>>> mkdir d1/d2/d3/d4/
>>>> mkdir d1/d2/d3/d4/d5
>>>> touch d1/d2/d3/d4/d5/f
>>>>
>>>>>      Xiaoxi
