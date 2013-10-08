From: Abhay Sachan <abhaysac-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ceph-create-keys hung
Date: Tue, 8 Oct 2013 15:15:18 +0530
Message-ID: <CAK72ynab6v_nCxE3wVoEsw38g=ektR_yVHha=rhbeXAx84ys3w@mail.gmail.com>
References: <CAK72ynaw9YqN8AUae2N1ZdkCaMhCEbQ8tKn_tYB=RUk6e7RFdA@mail.gmail.com>
	<524D86C3.3010307@inktank.com>
	<CAK72ynaai=RAPvWoyc7p9Qrh1dFkuxUiEL3rzDRv66zoVySA_g@mail.gmail.com>
	<5253CCE3.4060808@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0446375118=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5253CCE3.4060808-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Joao Eduardo Luis <joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0446375118==
Content-Type: multipart/alternative; boundary=001a1133b2d0932f2304e837a185

--001a1133b2d0932f2304e837a185
Content-Type: text/plain; charset=UTF-8

Hi Joao,
I gave the path for the keyring, and these messages are being printed on
the screen:

2013-10-07 15:18:55.048151 7fa1c43bc700  0 -- :/1026989 >>
15.213.24.231:6789/0 pipe(0x7fa1b4000990 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b400dfe0).fault
2013-10-07 15:18:58.048774 7fa1c42bb700  0 -- :/1026989 >>
15.213.24.230:6789/0 pipe(0x7fa1b4001cb0 sd=3 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b4002290).fault
2013-10-07 15:19:01.049193 7fa1c43bc700  0 -- :/1026989 >>
15.213.24.231:6789/0 pipe(0x7fa1b4000990 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b40038b0).fault
2013-10-07 15:19:04.049690 7fa1c42bb700  0 -- :/1026989 >>
15.213.24.241:6789/0 pipe(0x7fa1b4001cb0 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b4002590).fault
2013-10-07 15:19:07.050098 7fa1c43bc700  0 -- :/1026989 >>
15.213.24.231:6789/0 pipe(0x7fa1b4000990 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b40038b0).fault
2013-10-07 15:19:10.050467 7fa1c42bb700  0 -- :/1026989 >>
15.213.24.230:6789/0 pipe(0x7fa1b4001cb0 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b4005710).fault
2013-10-07 15:19:13.051033 7fa1c43bc700  0 -- :/1026989 >>
15.213.24.241:6789/0 pipe(0x7fa1b4000990 sd=3 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b4005870).fault
2013-10-07 15:19:16.051257 7fa1c42bb700  0 -- :/1026989 >>
15.213.24.231:6789/0 pipe(0x7fa1b4001cb0 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b40042e0).fault
2013-10-07 15:19:19.051823 7fa1c43bc700  0 -- :/1026989 >>
15.213.24.241:6789/0 pipe(0x7fa1b4000990 sd=3 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b4004990).fault
2013-10-07 15:19:22.052177 7fa1c42bb700  0 -- :/1026989 >>
15.213.24.230:6789/0 pipe(0x7fa1b4001cb0 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b40042e0).fault
2013-10-07 15:19:25.052526 7fa1c43bc700  0 -- :/1026989 >>
15.213.24.241:6789/0 pipe(0x7fa1b4000990 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b400f4a0).fault
2013-10-07 15:19:28.053000 7fa1c42bb700  0 -- :/1026989 >>
15.213.24.231:6789/0 pipe(0x7fa1b4007d90 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b4007250).fault
2013-10-07 15:19:31.053452 7fa1c43bc700  0 -- :/1026989 >>
15.213.24.230:6789/0 pipe(0x7fa1b4000990 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b400f4a0).fault
2013-10-07 15:19:34.054070 7fa1c42bb700  0 -- :/1026989 >>
15.213.24.241:6789/0 pipe(0x7fa1b4001cb0 sd=3 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b4007d90).fault
2013-10-07 15:19:37.054303 7fa1c43bc700  0 -- :/1026989 >>
15.213.24.230:6789/0 pipe(0x7fa1b4000990 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b400a7e0).fault
2013-10-07 15:19:40.054724 7fa1c42bb700  0 -- :/1026989 >>
15.213.24.241:6789/0 pipe(0x7fa1b4001cb0 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b400a1b0).fault
2013-10-07 15:19:43.055099 7fa1c43bc700  0 -- :/1026989 >>
15.213.24.231:6789/0 pipe(0x7fa1b4000990 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b4009610).fault
2013-10-07 15:19:46.055462 7fa1c42bb700  0 -- :/1026989 >>
15.213.24.230:6789/0 pipe(0x7fa1b4001cb0 sd=3 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b4007d90).fault
2013-10-07 15:19:49.056004 7fa1c43bc700  0 -- :/1026989 >>
15.213.24.231:6789/0 pipe(0x7fa1b4000990 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b400c5a0).fault
2013-10-07 15:19:52.056492 7fa1c42bb700  0 -- :/1026989 >>
15.213.24.230:6789/0 pipe(0x7fa1b4001cb0 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b400b000).fault
2013-10-07 15:19:55.056740 7fa1c43bc700  0 -- :/1026989 >>
15.213.24.231:6789/0 pipe(0x7fa1b4000990 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b40111b0).fault
2013-10-07 15:19:58.057117 7fa1c42bb700  0 -- :/1026989 >>
15.213.24.241:6789/0 pipe(0x7fa1b4009110 sd=3 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b400b4a0).fault
2013-10-07 15:20:01.057596 7fa1c43bc700  0 -- :/1026989 >>
15.213.24.230:6789/0 pipe(0x7fa1b400bc00 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b400be60).fault
2013-10-07 15:20:04.058191 7fa1c42bb700  0 -- :/1026989 >>
15.213.24.231:6789/0 pipe(0x7fa1b400d170 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b4015300).fault
2013-10-07 15:20:07.058837 7fa1c43bc700  0 -- :/1026989 >>
15.213.24.230:6789/0 pipe(0x7fa1b400f640 sd=3 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b400bc00).fault
2013-10-07 15:20:10.059147 7fa1c42bb700  0 -- :/1026989 >>
15.213.24.231:6789/0 pipe(0x7fa1b400d170 sd=4 :0 s=1 pgs=0 cs=0 l=1
c=0x7fa1b40015c0).fault


Regards,
Abhay




On Tue, Oct 8, 2013 at 2:44 PM, Joao Eduardo Luis <joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>wrote:

> On 08/10/13 05:40, Abhay Sachan wrote:
>
>> Hi Joao,
>> Thanks for replying. All of my monitors are up and running and connected
>> to each other. "ceph -s" is failing on the cluster with following error:
>>
>> 2013-10-07 10:12:25.099261 7fd1b948d700 -1 monclient(hunting): ERROR:
>> missing keyring, cannot use cephx for authentication
>> 2013-10-07 10:12:25.099271 7fd1b948d700  0 librados: client.admin
>> initialization error (2) No such file or directory
>> Error connecting to cluster: ObjectNotFound
>>
>
> This says it all.  You're somehow missing your keyring.  Or maybe you're
> not but you're keeping it in a non-default location and you're not
> specifying a path to it either on your ceph.conf or via '--keyring <path>'.
>
>
>
>  And the logs on each monitor has lots of entries like this:
>> NODE 1:
>>
>> 2013-10-07 03:58:51.153847 7ff2864c6700  0
>> mon.jul@0(probing).data_**health(0) update_stats avail 76% total 42332700
>> used 7901820 avail 32280480
>> 2013-10-07 03:59:51.154051 7ff2864c6700  0
>> mon.jul@0(probing).data_**health(0) update_stats avail 76% total 42332700
>> used 7901832 avail 32280468
>> 2013-10-07 04:00:51.154256 7ff2864c6700  0
>> mon.jul@0(probing).data_**health(0) update_stats avail 76% total 42332700
>> used 7901828 avail 32280472
>>
>
> Those messages are simply reports on the mon store's storage capacity.
>
>
>   -Joao
>
>
>>
>> Regards,
>> Abhay
>>
>> On Thu, Oct 3, 2013 at 8:31 PM, Joao Eduardo Luis <joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org
>> <mailto:joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>**> wrote:
>>
>>     On 10/03/2013 02:44 PM, Abhay Sachan wrote:
>>
>>         Hi All,
>>         I have tried setting up a ceph cluster with 3 nodes (3
>>         monitors). I am
>>         using RHEL 6.4 as OS with dumpling(0.67.3) release. Ceph cluster
>>         creation (using ceph-deploy as well as mkcephfs),
>> ceph-creates-keys
>>         doesn't return on any of the servers. Whereas, if I create a
>> cluster
>>         with only 1 node (1 monitor), key creation goes through. Has
>> anybody
>>         seen this problem or any ideas what I might be missing??
>>
>>         Regards,
>>         Abhay
>>
>>
>>     Those symptoms tell me that your monitors are not forming quorum.
>>     'ceph-create-keys' needs the monitors to first establish a quorum,
>>     otherwise it will hang waiting for that to happen.
>>
>>     Please make sure all your monitors are running.  If so, try running
>>     'ceph -s' on your cluster.  If that hangs as well, try accessing
>>     each monitor's admin socket to check what's happening [1].  If that
>>     too fails, try looking into the logs for something obviously wrong.
>>       If you are not able to discern anything useful at that point,
>>     upload the logs to some place and point us to them -- we'll then be
>>     happy to take a look.
>>
>>     Hope this helps.
>>
>>        -Joao
>>
>>     --
>>     Joao Eduardo Luis
>>     Software Engineer | http://inktank.com | http://ceph.com
>>
>>
>>
>
> --
> Joao Eduardo Luis
> Software Engineer | http://inktank.com | http://ceph.com
>

--001a1133b2d0932f2304e837a185
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi Joao,<br></div>I gave the path for the k=
eyring, and these messages are being printed on the screen:<br><br>2013-10-=
07 15:18:55.048151 7fa1c43bc700=C2=A0 0 -- :/1026989 &gt;&gt; <a href=3D"ht=
tp://15.213.24.231:6789/0">15.213.24.231:6789/0</a> pipe(0x7fa1b4000990 sd=
=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b400dfe0).fault<br>

2013-10-07 15:18:58.048774 7fa1c42bb700=C2=A0 0 -- :/1026989 &gt;&gt; <a hr=
ef=3D"http://15.213.24.230:6789/0">15.213.24.230:6789/0</a> pipe(0x7fa1b400=
1cb0 sd=3D3 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b4002290).fault<br>2013=
-10-07 15:19:01.049193 7fa1c43bc700=C2=A0 0 -- :/1026989 &gt;&gt; <a href=
=3D"http://15.213.24.231:6789/0">15.213.24.231:6789/0</a> pipe(0x7fa1b40009=
90 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b40038b0).fault<br>

2013-10-07 15:19:04.049690 7fa1c42bb700=C2=A0 0 -- :/1026989 &gt;&gt; <a hr=
ef=3D"http://15.213.24.241:6789/0">15.213.24.241:6789/0</a> pipe(0x7fa1b400=
1cb0 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b4002590).fault<br>2013=
-10-07 15:19:07.050098 7fa1c43bc700=C2=A0 0 -- :/1026989 &gt;&gt; <a href=
=3D"http://15.213.24.231:6789/0">15.213.24.231:6789/0</a> pipe(0x7fa1b40009=
90 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b40038b0).fault<br>

2013-10-07 15:19:10.050467 7fa1c42bb700=C2=A0 0 -- :/1026989 &gt;&gt; <a hr=
ef=3D"http://15.213.24.230:6789/0">15.213.24.230:6789/0</a> pipe(0x7fa1b400=
1cb0 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b4005710).fault<br>2013=
-10-07 15:19:13.051033 7fa1c43bc700=C2=A0 0 -- :/1026989 &gt;&gt; <a href=
=3D"http://15.213.24.241:6789/0">15.213.24.241:6789/0</a> pipe(0x7fa1b40009=
90 sd=3D3 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b4005870).fault<br>

2013-10-07 15:19:16.051257 7fa1c42bb700=C2=A0 0 -- :/1026989 &gt;&gt; <a hr=
ef=3D"http://15.213.24.231:6789/0">15.213.24.231:6789/0</a> pipe(0x7fa1b400=
1cb0 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b40042e0).fault<br>2013=
-10-07 15:19:19.051823 7fa1c43bc700=C2=A0 0 -- :/1026989 &gt;&gt; <a href=
=3D"http://15.213.24.241:6789/0">15.213.24.241:6789/0</a> pipe(0x7fa1b40009=
90 sd=3D3 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b4004990).fault<br>

2013-10-07 15:19:22.052177 7fa1c42bb700=C2=A0 0 -- :/1026989 &gt;&gt; <a hr=
ef=3D"http://15.213.24.230:6789/0">15.213.24.230:6789/0</a> pipe(0x7fa1b400=
1cb0 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b40042e0).fault<br>2013=
-10-07 15:19:25.052526 7fa1c43bc700=C2=A0 0 -- :/1026989 &gt;&gt; <a href=
=3D"http://15.213.24.241:6789/0">15.213.24.241:6789/0</a> pipe(0x7fa1b40009=
90 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b400f4a0).fault<br>

2013-10-07 15:19:28.053000 7fa1c42bb700=C2=A0 0 -- :/1026989 &gt;&gt; <a hr=
ef=3D"http://15.213.24.231:6789/0">15.213.24.231:6789/0</a> pipe(0x7fa1b400=
7d90 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b4007250).fault<br>2013=
-10-07 15:19:31.053452 7fa1c43bc700=C2=A0 0 -- :/1026989 &gt;&gt; <a href=
=3D"http://15.213.24.230:6789/0">15.213.24.230:6789/0</a> pipe(0x7fa1b40009=
90 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b400f4a0).fault<br>

2013-10-07 15:19:34.054070 7fa1c42bb700=C2=A0 0 -- :/1026989 &gt;&gt; <a hr=
ef=3D"http://15.213.24.241:6789/0">15.213.24.241:6789/0</a> pipe(0x7fa1b400=
1cb0 sd=3D3 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b4007d90).fault<br>2013=
-10-07 15:19:37.054303 7fa1c43bc700=C2=A0 0 -- :/1026989 &gt;&gt; <a href=
=3D"http://15.213.24.230:6789/0">15.213.24.230:6789/0</a> pipe(0x7fa1b40009=
90 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b400a7e0).fault<br>

2013-10-07 15:19:40.054724 7fa1c42bb700=C2=A0 0 -- :/1026989 &gt;&gt; <a hr=
ef=3D"http://15.213.24.241:6789/0">15.213.24.241:6789/0</a> pipe(0x7fa1b400=
1cb0 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b400a1b0).fault<br>2013=
-10-07 15:19:43.055099 7fa1c43bc700=C2=A0 0 -- :/1026989 &gt;&gt; <a href=
=3D"http://15.213.24.231:6789/0">15.213.24.231:6789/0</a> pipe(0x7fa1b40009=
90 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b4009610).fault<br>

2013-10-07 15:19:46.055462 7fa1c42bb700=C2=A0 0 -- :/1026989 &gt;&gt; <a hr=
ef=3D"http://15.213.24.230:6789/0">15.213.24.230:6789/0</a> pipe(0x7fa1b400=
1cb0 sd=3D3 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b4007d90).fault<br>2013=
-10-07 15:19:49.056004 7fa1c43bc700=C2=A0 0 -- :/1026989 &gt;&gt; <a href=
=3D"http://15.213.24.231:6789/0">15.213.24.231:6789/0</a> pipe(0x7fa1b40009=
90 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b400c5a0).fault<br>

2013-10-07 15:19:52.056492 7fa1c42bb700=C2=A0 0 -- :/1026989 &gt;&gt; <a hr=
ef=3D"http://15.213.24.230:6789/0">15.213.24.230:6789/0</a> pipe(0x7fa1b400=
1cb0 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b400b000).fault<br>2013=
-10-07 15:19:55.056740 7fa1c43bc700=C2=A0 0 -- :/1026989 &gt;&gt; <a href=
=3D"http://15.213.24.231:6789/0">15.213.24.231:6789/0</a> pipe(0x7fa1b40009=
90 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b40111b0).fault<br>

2013-10-07 15:19:58.057117 7fa1c42bb700=C2=A0 0 -- :/1026989 &gt;&gt; <a hr=
ef=3D"http://15.213.24.241:6789/0">15.213.24.241:6789/0</a> pipe(0x7fa1b400=
9110 sd=3D3 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b400b4a0).fault<br>2013=
-10-07 15:20:01.057596 7fa1c43bc700=C2=A0 0 -- :/1026989 &gt;&gt; <a href=
=3D"http://15.213.24.230:6789/0">15.213.24.230:6789/0</a> pipe(0x7fa1b400bc=
00 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b400be60).fault<br>

2013-10-07 15:20:04.058191 7fa1c42bb700=C2=A0 0 -- :/1026989 &gt;&gt; <a hr=
ef=3D"http://15.213.24.231:6789/0">15.213.24.231:6789/0</a> pipe(0x7fa1b400=
d170 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b4015300).fault<br>2013=
-10-07 15:20:07.058837 7fa1c43bc700=C2=A0 0 -- :/1026989 &gt;&gt; <a href=
=3D"http://15.213.24.230:6789/0">15.213.24.230:6789/0</a> pipe(0x7fa1b400f6=
40 sd=3D3 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b400bc00).fault<br>

2013-10-07 15:20:10.059147 7fa1c42bb700=C2=A0 0 -- :/1026989 &gt;&gt; <a hr=
ef=3D"http://15.213.24.231:6789/0">15.213.24.231:6789/0</a> pipe(0x7fa1b400=
d170 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D1 c=3D0x7fa1b40015c0).fault<br><br>=
<br></div>Regards,<br>

</div>Abhay<br><br><br></div><div class=3D"gmail_extra"><br><br><div class=
=3D"gmail_quote">On Tue, Oct 8, 2013 at 2:44 PM, Joao Eduardo Luis <span di=
r=3D"ltr">&lt;<a href=3D"mailto:joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">jo=
ao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On 08/10/13 05:40, Abhay S=
achan wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi Joao,<br>
Thanks for replying. All of my monitors are up and running and connected<br=
>
to each other. &quot;ceph -s&quot; is failing on the cluster with following=
 error:<br>
<br>
2013-10-07 10:12:25.099261 7fd1b948d700 -1 monclient(hunting): ERROR:<br>
missing keyring, cannot use cephx for authentication<br>
2013-10-07 10:12:25.099271 7fd1b948d700 =C2=A00 librados: client.admin<br>
initialization error (2) No such file or directory<br>
Error connecting to cluster: ObjectNotFound<br>
</blockquote>
<br></div>
This says it all. =C2=A0You&#39;re somehow missing your keyring. =C2=A0Or m=
aybe you&#39;re not but you&#39;re keeping it in a non-default location and=
 you&#39;re not specifying a path to it either on your ceph.conf or via &#3=
9;--keyring &lt;path&gt;&#39;.<div class=3D"im">

<br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
And the logs on each monitor has lots of entries like this:<br>
NODE 1:<br>
<br>
2013-10-07 03:58:51.153847 7ff2864c6700 =C2=A00<br>
mon.jul@0(probing).data_<u></u>health(0) update_stats avail 76% total 42332=
700<br>
used 7901820 avail 32280480<br>
2013-10-07 03:59:51.154051 7ff2864c6700 =C2=A00<br>
mon.jul@0(probing).data_<u></u>health(0) update_stats avail 76% total 42332=
700<br>
used 7901832 avail 32280468<br>
2013-10-07 04:00:51.154256 7ff2864c6700 =C2=A00<br>
mon.jul@0(probing).data_<u></u>health(0) update_stats avail 76% total 42332=
700<br>
used 7901828 avail 32280472<br>
</blockquote>
<br></div>
Those messages are simply reports on the mon store&#39;s storage capacity.<=
span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
=C2=A0 -Joao<br>
<br>
</font></span><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div class=3D"im">
<br>
<br>
Regards,<br>
Abhay<br>
<br>
On Thu, Oct 3, 2013 at 8:31 PM, Joao Eduardo Luis &lt;<a href=3D"mailto:joa=
o.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a><br></div><d=
iv><div class=3D"h5">
&lt;mailto:<a href=3D"mailto:joao.luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">joao.=
luis-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt;<u></u>&gt; wrote:<br>
<br>
=C2=A0 =C2=A0 On 10/03/2013 02:44 PM, Abhay Sachan wrote:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Hi All,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 I have tried setting up a ceph cluster with 3 n=
odes (3<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 monitors). I am<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 using RHEL 6.4 as OS with dumpling(0.67.3) rele=
ase. Ceph cluster<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 creation (using ceph-deploy as well as mkcephfs=
), ceph-creates-keys<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 doesn&#39;t return on any of the servers. Where=
as, if I create a cluster<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 with only 1 node (1 monitor), key creation goes=
 through. Has anybody<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 seen this problem or any ideas what I might be =
missing??<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Regards,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Abhay<br>
<br>
<br>
=C2=A0 =C2=A0 Those symptoms tell me that your monitors are not forming quo=
rum.<br>
=C2=A0 =C2=A0 &#39;ceph-create-keys&#39; needs the monitors to first establ=
ish a quorum,<br>
=C2=A0 =C2=A0 otherwise it will hang waiting for that to happen.<br>
<br>
=C2=A0 =C2=A0 Please make sure all your monitors are running. =C2=A0If so, =
try running<br>
=C2=A0 =C2=A0 &#39;ceph -s&#39; on your cluster. =C2=A0If that hangs as wel=
l, try accessing<br>
=C2=A0 =C2=A0 each monitor&#39;s admin socket to check what&#39;s happening=
 [1]. =C2=A0If that<br>
=C2=A0 =C2=A0 too fails, try looking into the logs for something obviously =
wrong.<br>
=C2=A0 =C2=A0 =C2=A0 If you are not able to discern anything useful at that=
 point,<br>
=C2=A0 =C2=A0 upload the logs to some place and point us to them -- we&#39;=
ll then be<br>
=C2=A0 =C2=A0 happy to take a look.<br>
<br>
=C2=A0 =C2=A0 Hope this helps.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0-Joao<br>
<br>
=C2=A0 =C2=A0 --<br>
=C2=A0 =C2=A0 Joao Eduardo Luis<br>
=C2=A0 =C2=A0 Software Engineer | <a href=3D"http://inktank.com" target=3D"=
_blank">http://inktank.com</a> | <a href=3D"http://ceph.com" target=3D"_bla=
nk">http://ceph.com</a><br>
<br>
<br>
</div></div></blockquote><div class=3D"HOEnZb"><div class=3D"h5">
<br>
<br>
-- <br>
Joao Eduardo Luis<br>
Software Engineer | <a href=3D"http://inktank.com" target=3D"_blank">http:/=
/inktank.com</a> | <a href=3D"http://ceph.com" target=3D"_blank">http://cep=
h.com</a><br>
</div></div></blockquote></div><br></div>

--001a1133b2d0932f2304e837a185--

--===============0446375118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0446375118==--
