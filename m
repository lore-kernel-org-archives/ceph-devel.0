From: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Ceph Package Repo on Ubuntu Precise(12.04) is
	broken
Date: Mon, 24 Apr 2017 16:20:05 -0400
Message-ID: <CAC-Np1xyYM4p=WzX7AfQF4tfqu0KpZNhPW94SzKxDk2BN9anZg@mail.gmail.com>
References: <CAEYCsVL3SAwAr26nVFJcZqwXJM2skj5AztFSj15VRGQXvRrEvQ@mail.gmail.com>
	<CALJWc2vwBSniKR0_-dD8pK2bNmMRvj7xMD-t2qYWNrt1qy_5iQ@mail.gmail.com>
	<CAEYCsVK1YWb-0ihZ_hCz_NRYwPcosCBcL0Gq8y06VNy2gV7h0A@mail.gmail.com>
	<CAC-Np1y2ohw7NCWjthpwpZp0JL8Yn14UAxsbh6fVWtcZ1GgNkg@mail.gmail.com>
	<CAC-Np1wPAnB2gWkmdvrvk6Wf7_OUofmg3Q9D85K49JBZvfBAHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAC-Np1wPAnB2gWkmdvrvk6Wf7_OUofmg3Q9D85K49JBZvfBAHQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Xiaoxi Chen <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: xiaoguang fan <fanxiaoguang008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Apr 24, 2017 at 10:05 AM, Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Mon, Apr 24, 2017 at 8:53 AM, Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> On Mon, Apr 24, 2017 at 2:41 AM, Xiaoxi Chen <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> Well, I can definitely build my own,
>>>
>>> 1. Precise is NOT EOL on Hammer release, which was confirmed in
>>> previous mail thread. So we still need to maintain point-in-time
>>> hammer package for end users.
>>
>> Ceph Hammer is EOL
>>
>>>
>>> 2. It is NOT ONLY missing 0.94.10, instead, as how we organize the
>>> repo index(only contains latest package in  index), now all 0.94.x
>>> package on precise are not installable via apt.

Can you try now? 0.94.10 for precise was just pushed out.

Let me know if you get into any issues
>>>
>>
>> I think this may be because we didn't built precise for 0.94.10 and
>> Debian repositories do not support multi-version packages. So although
>> other versions are there, but the latest one isn't, the repository
>> acts as there is nothing for Precise.
>>
>> I would suggest an upgrade to a newer Ceph version at this point,
>> although Precise isn't built for any newer Ceph versions, so
>> effectively you are looking at
>> upgrading to a newer OS as well.
>>
>>>
>>> 2017-04-24 14:02 GMT+08:00 xiaoguang fan <fanxiaoguang008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>>> If you need this deb package 0.94.10 on precise(12.04), I think you can
>>>> build it by yourself, you can use the script make_deps.sh
>>>>
>>>> 2017-04-24 11:35 GMT+08:00 Xiaoxi Chen <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>>>>
>>>>> Hi,
>>>>>
>>>>>      The 0.94.10 packages were not build for Ubuntu Precise, till now.
>>>>> What is worse, the dist discription
>>>>>
>>>>> (http://download.ceph.com/debian-hammer/dists/precise/main/binary-amd64/Packages)
>>>>>  doesnt contains any ceph core pacages.
>>>>>
>>>>>      It make Precise user unable provision their ceph cluster/client.
>>>>> Could anyone pls help to fix it?
>
> I've started to build the Precise packages for that version, hopefully
> we can get something worked out today or tomorrow. You are right that
> Precise wasn't EOL when
> that version of Hammer was released, and this was an omission on our end.
>
>
>>>>>
>>>>> Xiaoxi
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
