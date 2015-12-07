From: "Yan, Zheng" <ukernel@gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_how_to_see_file_object=2Dmappings_for_ceph?=
	=?UTF-8?Q?fuse_client?=
Date: Mon, 7 Dec 2015 16:43:35 +0800
Message-ID: <CAAM7YA=bcqDfh0GVvxVXOdo0x239LkP+Z9rQ3txdYOJ9_Zo3QQ@mail.gmail.com>
References: <F075EA5A8A3F8045B2A81359C8B5B07C5E3E8A52@H3CMLB12-EX.srv.huawei-3com.com>
	<CAAM7YAkdHJ0jCWDhWBRX2v7tCiXxw7ZM3T39Lk5=6XHNCo2EOA@mail.gmail.com>
	<F075EA5A8A3F8045B2A81359C8B5B07C5E3E9B12@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:34424 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbbLGInh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Dec 2015 03:43:37 -0500
Received: by lbbcs9 with SMTP id cs9so53660252lbb.1
        for <ceph-devel@vger.kernel.org>; Mon, 07 Dec 2015 00:43:35 -0800 (PST)
In-Reply-To: <F075EA5A8A3F8045B2A81359C8B5B07C5E3E9B12@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wuxiangwei <wuxiangwei@h3c.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Mon, Dec 7, 2015 at 1:52 PM, Wuxiangwei <wuxiangwei@h3c.com> wrote:
> Thanks Yan, what if we wanna see some more specific or detailed infor=
mation? E.g. with cephfs we may run 'cephfs /mnt/a.txt show_location --=
offset' to find the location of a given offset.
>

When using default layout, object size is 4M, (offset / 4194304) is
subfix of object name. For example. offset 0 is located in object
<inode number in hex>.00000000, offset 4194304 is located in object
<inode number in hex>.0000001.

=46or fancy layout, please read
http://docs.ceph.com/docs/master/dev/file-striping/

> -----------------------
> Wu Xiangwei
> Tel : 0571-86760875
> 2014 UIS 2, TEAM BORE
>
>
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Yan, Zheng [mailto:ukernel@gmail.com]
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2015=E5=B9=B412=E6=9C=887=E6=97=
=A5 11:22
> =E6=94=B6=E4=BB=B6=E4=BA=BA: wuxiangwei 09660 (RD)
> =E6=8A=84=E9=80=81: ceph-devel@vger.kernel.org; ceph-users@lists.ceph=
=2Ecom
> =E4=B8=BB=E9=A2=98: Re: how to see file object-mappings for cephfuse =
client
>
> On Mon, Dec 7, 2015 at 10:51 AM, Wuxiangwei <wuxiangwei@h3c.com> wrot=
e:
>> Hi, Everyone
>>
>> Recently I'm trying to figure out how to use ceph-fuse. If we mount =
cephfs as the kernel client, there is a 'cephfs' command tool (though i=
t seems to be 'deprecated') with 'map' and 'show_location' commands to =
show the RADOS objects belonging to a given file. However, it doesn't w=
ork well for ceph-fuse, neither can I find a similar tool to see the ma=
ppings. Any suggestions?
>> Thank you!
>
> Rados objects  for a give inode is in form <inode number in hex>.xxxx=
xxxx.
>
> To get a file's layout, you can use getfattr -n ceph.file.layout <fil=
e name>
>
> To find a given object is stored on which OSDs, you can use command, =
ceph osd map <cephfs data pool> <object name>
>
>>
>>
>> -----------------------
>> Wu Xiangwei
>> Tel : 0571-86760875
>> 2014 UIS 2, TEAM BORE
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
