From: Ketor D <d.ketor@gmail.com>
Subject: Re: [Ceph-Dokan] A Windows CephFS Client Project
Date: Wed, 7 Jan 2015 23:17:21 +0800
Message-ID: <CAM9_UU_xXjVheGNQ8Fkk7cp1s7gJw8W6E5WVfk-wCGnNkwiqdw@mail.gmail.com>
References: <CAM9_UU_4bnWVVf3bC8wnggNmF5O+HUshZn_xP-_ELiW3kqt=+Q@mail.gmail.com>
 <E769996A-DEED-4223-B36B-5A6C26539962@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61476 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbbAGPRw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Jan 2015 10:17:52 -0500
Received: by mail-ob0-f174.google.com with SMTP id uz6so3504690obc.5
        for <ceph-devel@vger.kernel.org>; Wed, 07 Jan 2015 07:17:51 -0800 (PST)
In-Reply-To: <E769996A-DEED-4223-B36B-5A6C26539962@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Van Der Ster <daniel.vanderster@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Dan,
Dokan only provide the interface of filesystem :(
And ceph-dokan only build libcephfs.dll right now.

Librbd and libcephfs share much same code on client side, so implement
the librbd in ceph-dokan project is not hard work.
I will try to implement librbd, librados interface in ceph-dokan
project in the future.
If you are interested in librbd on win32, you are welcome to improve ceph-dokan.

Thank you very much!
Ketor


2015-01-07 22:16 GMT+08:00 Dan Van Der Ster <daniel.vanderster@cern.ch>:
> Dear Ketor,
> Congratulations, this is very interesting!
> Sorry to ask the obvious question, but does Dokan provide the needed interface to write a block device client, i.e. an RBD client ?
> Cheers, Dan
>
>> On 07 Jan 2015, at 05:09, Ketor D <d.ketor@gmail.com> wrote:
>>
>> Hi everyone,
>>
>> A new project ceph-dokan (https://github.com/ceph/ceph-dokan) is
>> open-source to all now.
>> You can access the cephfs on Windows directly using ceph-dokan, not by
>> smb or whatever.
>> And you will get the full experience and performance of cephfs on Windows now.
>>
>> Here is something about this project you may want to know.
>>
>>     Overview.
>>         ceph-dokan is build on MinGW. It will provide ceph-dokan.exe
>> and libcephfs.dll.
>>         ceph-dokan.exe makes you use CephFS as a volume like your [C:] or [D:].
>>         libcephfs.dll is a lib you can write your own application using CephFS.
>>
>>      Features:
>>         Support almost windows filesystem api's.
>>         Support ACL from Linux.
>>         Support CreateFile of temp file.
>>         Support Microsoft Office file edit and save.
>>         etc.
>>
>>      Internal:
>>         ceph-dokan is ported from upstream Ceph. It was first ported
>> as a standalone Ceph Client and then portd to Cygwin. But Cygwin is
>> too slowly and not native code so it was ported to MinGW later. And
>> with dokan(like fuse), now ceph-dokan map cephfs as a volume on
>> windows.
>>         ceph-dokan is fully native win32 code and compiled by gcc. So
>> its performace is very good. Also it use winsock2 instead of linux
>> socket and select() instead of poll(). And etc....
>>
>> Everyone who have experience on dokan, mingw, win32 can help to
>> improve ceph-dokan by pull request or using ceph-devel mailing list.
>>
>> Thanks!
>> Ketor
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
