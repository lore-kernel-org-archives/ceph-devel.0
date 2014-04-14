From: xiao xianxia <xianxiaxiao@ubuntukylin.com>
Subject: Re: location-aware file placement in Ceph
Date: Mon, 14 Apr 2014 09:27:24 +0800
Message-ID: <534B397C.30103@ubuntukylin.com>
References: <AKYAowCzAHlylsi1xeYx2apM.1.1393551692725.Hmail.xianxiaxiao@ubuntukylin.com> <53457C07.3060507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:43775 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbaDNBg1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Apr 2014 21:36:27 -0400
In-Reply-To: <53457C07.3060507@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhongliang Zhao <zhaozhongliang@gmail.com>
Cc: ceph-devel@vger.kernel.org, liwang <liwang@ubuntukylin.com>

Hi Zhongliang,
     you can find a lot of command on ceph official document!


=E4=BA=8E 2014/4/10 0:57, Zhongliang Zhao =E5=86=99=E9=81=93:
> Hi XIanxia,
>
> Thanks a lot for the reply.
>
> Since I am new to ceph, some parts of your reply is unclear to me. Is=
=20
> it possible for you to make it more clear? Thanks a lot for your time=
=2E
>
> On 02/28/2014 02:41 AM, Xianxia Xiao wrote:
>>
>> May be able to meet your needs through rbd.
>>
>>
>> You can create multiple rules,and then specify a different pool to=20
>> use a different ruleset.
> Where can I modify or creat the rule? On the monitor node? and how to=
=20
> configure a pool to use a ruleset?
you can use crushtool export crush map,then modify the rule in crush ma=
p=20
,you can create new rules.
http://ceph.com/docs/master/rados/operations/crush-map/?highlight=3Dcru=
sh%20map

you can use #ceph osd pool set {pool name} {key} {value}
the key is crush_ruleset,value is the rule num.
>> Then create multiple block images, and Specify image to different po=
ols.
> How this can be done?

you can see that in Block Device Command in ceph document.
http://ceph.com/docs/master/rbd/rados-rbd-cmds/

>> create  file system on the block device and mount file system on=20
>> different positions,so that the different location of the file can=20
>> use different ruleset.
> How do I know to where I should mount the file system?
You decide,mount command is the same to linux mount command.

>
> Best regards,
> Zhongliang Zhao
>>
>>
>>
Best regards,
xian xia
>>
>>
>>
>>
>>
>>> -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
>>> =E5=8F=91=E4=BB=B6=E4=BA=BA: Zhongliang Zhao<zhaozhongliang@gmail.c=
om>
>>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2014=E5=B9=B42=E6=9C=8827=E6=97=
=A5 =E6=98=9F=E6=9C=9F=E5=9B=9B
>>> =E6=94=B6=E4=BB=B6=E4=BA=BA: ceph-devel@vger.kernel.org
>>> =E6=8A=84=E9=80=81:
>>> =E4=B8=BB=E9=A2=98: location-aware file placement in Ceph
>>>
>>> Dear all,
>>>
>>> As new to ceph, may I ask in the crush algorithm, is there a way to
>>> configure where the file to be stored, not randomly.
>>> My requirement is to place the files that within the same
>>> location(within a geographic area), into the same OSD, instead of
>>> randomly placing them seperately.
>>>
>>> I guess crush may support this. But to do this, I just have to=20
>>> configure
>>> some parameters in some ceph commands? or I have to modify the ceph
>>> crush algorithm and re-compile ceph?
>>>
>>> Many thanks for any helpful pointers.
>>>
>>> Cheers, Giovanni
>>> --=20
>>> To unsubscribe from this list: send the line "unsubscribe=20
>>> ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
