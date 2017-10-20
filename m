From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: Huge lookup when recursively mkdir
Date: Fri, 20 Oct 2017 15:28:54 +0800
Message-ID: <CAEYCsVL=bcaQY6SBQ=ujR9EEvK3FgUf38s+Bj5UU2Z8SjoPQtA@mail.gmail.com>
References: <CAEYCsVLCS5aPC8M8PAU5UTS0pKzhp1aWBW6L72ZwvUEetbstpw@mail.gmail.com>
 <CAAM7YAk2+ekeYdJ_E4d5wB_SoiL_eGA0P9fGuxvEkz3r11ytTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:48920 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbdJTH2z (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Oct 2017 03:28:55 -0400
Received: by mail-io0-f182.google.com with SMTP id j17so12355843iod.5
        for <ceph-devel@vger.kernel.org>; Fri, 20 Oct 2017 00:28:55 -0700 (PDT)
In-Reply-To: <CAAM7YAk2+ekeYdJ_E4d5wB_SoiL_eGA0P9fGuxvEkz3r11ytTQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, John Spray <jspray@redhat.com>

Centos 7.3, kernel version 3.10.0-514.26.2.el7.x86_64.

I extract the logical of file creation in our workload into a
reproducer , like below.

Concurrently run the reproducer in 2+ node can see a lots of lookup OP.
I thought the lookup is to open the directory tree so I tried to
pre-make most of the dirs ,  use ls -i trying to read the dentries and
cache it, then re-run the reproducer,  seems nothing different..

#include <sys/stat.h>
#include <fcntl.h>
int create_file(char * base, int count, int max, int depth)
{
    int i;
    for(i=0; i<count; i++) {
        char dir[256];
        int mydir = rand() % max;
        sprintf(dir, "%s/%d", path, mydir);
        if (depth >=1) {
            mkdir(dir,0777);
            create_dir(dir, count, max, depth - 1);
        } else {
            int fd = open(dir, O_CREAT | O_EXCL| O_WRONLY , 0666);
            printf("opened path : %s = %d\n", path, fd);
            close(fd);
        }
    }
}
int main(int argc, char argv[])
{
    char path[256];
    while(1) {
      create_file("/import/SQL01", 1, 4 ,10);
    }
}



2017-10-20 10:55 GMT+08:00 Yan, Zheng <ukernel@gmail.com>:
> On Fri, Oct 20, 2017 at 12:49 AM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
>> Hi,
>>
>>       I am seeing a lot of lookup request when doing recursive mkdir.
>>       The workload behavior is like:
>>           mkdir DIR0
>>           mkdir DIR0/DIR1
>>           mkdir DIR0/DIR1/DIR2
>>           ....
>>           mkdir DIR0/DIR1/DIR2......./DIR7
>>           create DIR0/DIR1/DIR2......./DIR7/FILE1
>>
>>       and concurrently run on 50+ clients, the dir name in different
>> clients may or maynot be the same.
>>
>>        from the admin socket I was seeing ~50K create requests, but
>> got 400K lookup requests. The lookup eat up most of the mds capability
>> so file create is slow.
>>
>>        Where is the lookup comes from and can we have anyway to
>> optimize it out ?
>>
>
> I don't see this behavior when running following commands in 4.13
> kernel client and luminous version ceph-fuse. which client do you use?
>
> mkdir d1
> mkdir d1/d2
> mkdir d1/d2/d3
> mkdir d1/d2/d3/d4/
> mkdir d1/d2/d3/d4/d5
> touch d1/d2/d3/d4/d5/f
>
>>      Xiaoxi
