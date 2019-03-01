From: Igor Fedotov <ifedotov-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ceph osd commit latency increase over time,
 until restart
Date: Fri, 1 Mar 2019 13:26:46 +0300
Message-ID: <d37edbfa-0ab5-ee1b-cbeb-3379badad9d1@suse.de>
References: <395511117.2665.1548405853447.JavaMail.zimbra@oxygem.tv>
 <2062110719.174905.1549294821422.JavaMail.zimbra@oxygem.tv>
 <d4558d4b-b1c9-211a-626a-0c14df3e29b9@suse.de>
 <825077993.841032.1549638894023.JavaMail.zimbra@oxygem.tv>
 <2132634351.842536.1549641461010.JavaMail.zimbra@oxygem.tv>
 <c26e0eca-1a1c-3354-bff6-4560e3aea4c5@suse.de>
 <1554220830.1076801.1550047328269.JavaMail.zimbra@oxygem.tv>
 <f97b81e4-265d-cd8e-3053-321d988720c4@suse.de>
 <19368722.1223708.1550237472044.JavaMail.zimbra@odiso.com>
 <056c13b4-fbcf-787f-cfbe-bb37044161f8@42on.com>
 <20190228205705.GB31731@shell.dmz.bit.nl>
 <392d66bb-5647-9b19-c17b-5259f4ed6749@suse.de>
 <c051fcb9-9c8c-32bd-7835-2182fade8d14@suse.de>
 <CAEYCsVJRqJDsS7iMXuk68ecFpPS9_qivuNPihXhy7E55o+GvoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5104475065458327088=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAEYCsVJRqJDsS7iMXuk68ecFpPS9_qivuNPihXhy7E55o+GvoA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
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
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============5104475065458327088==
Content-Type: multipart/alternative;
 boundary="------------4DACAD7450D8649415A83E64"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------4DACAD7450D8649415A83E64
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

resending, not sure the prev email reached the mailing list...


Hi Chen,

thanks for the update. Will prepare patch to periodically reset 
StupidAllocator today.

And just to let you know below is an e-mail from AdamK from RH which 
might explain the issue with the allocator.

Also please note that StupidAllocator might not perform full 
defragmentation in run-time. That's why we observed (mentioned somewhere 
in the thread) fragmentation growth while OSD is running and its drop on 
restart. Such a restart rebuilds internal tree and eliminates 
defragmentation flaws. May be that's the case.


Thanks,

Igor

-------- Forwarded Message --------
Subject:     High CPU in StupidAllocator
Date:     Tue, 12 Feb 2019 10:24:37 +0100
From:     Adam Kupczyk <akupczyk-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
To:     IGOR FEDOTOV <ifed75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


Hi Igor,

I have observed that StupidAllocator can burn a lot of CPU in 
StupidAllocator::allocate_int().
This comes from loops:
while (p != free[bin].end()) {
     if (_aligned_len(p, alloc_unit) >= want_size) {
       goto found;
     }
     ++p;
}

It happens when want_size is close to limit of size of bin.
For example, free[5] contains sizes 8192..16383.
When requesting size like 16000 it is quite likely that multiple chunks 
must be checked.

I have made an attempt to improve it by increasing amount of buckets.
It is done in aclamk/wip-bs-stupid-allocator-2 .

Best regards,

Adam Kupczyk



On 3/1/2019 11:46 AM, Xiaoxi Chen wrote:
> igor，
>    I can test the patch if we have a package.
>    My enviroment and workload can consistently reproduce the latency  
> 2-3 days after restarting.
>     Sage tells me to try bitmap allocator to make sure stupid 
> allocator is the bad guy. I have some osds in luminous +bitmap and 
> some osds in 14.1.0+bitmap.  Both looks positive till now, but i need 
> more time to be sure.
>      The perf ,log and admin socket analysis lead to the theory that 
> in alloc_int the loop sometimes take long time wkth allocator locks 
> held. Which blocks release part called from _txc_finish in 
> kv_finalize_thread, this thread is also the one to calculate 
> state_kv_committing_lat and overall commit_lat. You can find from 
> admin socket that state_done_latency has similar trend as commit_latency.
>     But we cannot find a theory to.explain why reboot helps, the 
> allocator btree will be rebuild from freelist manager and.it.should be 
> exactly. the same as it is prior to reboot.  Anything related with pg 
> recovery?
>
>    Anyway, as I have a live env and workload, I am more than willing 
> to work with you for further investigatiom
>
> -Xiaoxi
>
> Igor Fedotov <ifedotov-l3A5Bk7waGM@public.gmane.org <mailto:ifedotov-l3A5Bk7waGM@public.gmane.org>> 于 
> 2019年3月1日周五 上午6:21写道：
>
>     Also I think it makes sense to create a ticket at this point. Any
>     volunteers?
>
>     On 3/1/2019 1:00 AM, Igor Fedotov wrote:
>     > Wondering if somebody would be able to apply simple patch that
>     > periodically resets StupidAllocator?
>     >
>     > Just to verify/disprove the hypothesis it's allocator relateted
>     >
>     > On 2/28/2019 11:57 PM, Stefan Kooman wrote:
>     >> Quoting Wido den Hollander (wido-fspyXLx8qC4@public.gmane.org <mailto:wido-fspyXLx8qC4@public.gmane.org>):
>     >>> Just wanted to chime in, I've seen this with
>     Luminous+BlueStore+NVMe
>     >>> OSDs as well. Over time their latency increased until we
>     started to
>     >>> notice I/O-wait inside VMs.
>     >> On a Luminous 12.2.8 cluster with only SSDs we also hit this
>     issue I
>     >> guess. After restarting the OSD servers the latency would drop
>     to normal
>     >> values again. See https://owncloud.kooman.org/s/BpkUc7YM79vhcDj
>     >>
>     >> Reboots were finished at ~ 19:00.
>     >>
>     >> Gr. Stefan
>     >>
>

--------------4DACAD7450D8649415A83E64
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>resending, not sure the prev email reached the mailing list...</p>
    <p><br>
    </p>
    <p>Hi Chen,<br>
      <br>
      thanks for the update. Will prepare patch to periodically reset
      StupidAllocator today.<br>
      <br>
      And just to let you know below is an e-mail from AdamK from RH
      which might explain the issue with the allocator.<br>
      <br>
      Also please note that StupidAllocator might not perform full
      defragmentation in run-time. That's why we observed (mentioned
      somewhere in the thread) fragmentation growth while OSD is running
      and its drop on restart. Such a restart rebuilds internal tree and
      eliminates defragmentation flaws. May be that's the case.<br>
      <br>
      <br>
      Thanks,<br>
      <br>
      Igor<br>
      <br>
      -------- Forwarded Message --------<br>
      Subject:     High CPU in StupidAllocator<br>
      Date:     Tue, 12 Feb 2019 10:24:37 +0100<br>
      From:     Adam Kupczyk <a class="moz-txt-link-rfc2396E" href="mailto:akupczyk-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">&lt;akupczyk-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt;</a><br>
      To:     IGOR FEDOTOV <a class="moz-txt-link-rfc2396E" href="mailto:ifed75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;ifed75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
      <br>
      <br>
      Hi Igor,<br>
      <br>
      I have observed that StupidAllocator can burn a lot of CPU in
      StupidAllocator::allocate_int().<br>
      This comes from loops:<br>
      while (p != free[bin].end()) {<br>
          if (_aligned_len(p, alloc_unit) &gt;= want_size) {<br>
            goto found;<br>
          }<br>
          ++p;<br>
      }<br>
      <br>
      It happens when want_size is close to limit of size of bin.<br>
      For example, free[5] contains sizes 8192..16383.<br>
      When requesting size like 16000 it is quite likely that multiple
      chunks must be checked.<br>
      <br>
      I have made an attempt to improve it by increasing amount of
      buckets.<br>
      It is done in aclamk/wip-bs-stupid-allocator-2 .<br>
      <br>
      Best regards,<br>
      <br>
      Adam Kupczyk<br>
      <br>
      <br>
      <br>
    </p>
    <div class="moz-cite-prefix">On 3/1/2019 11:46 AM, Xiaoxi Chen
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAEYCsVJRqJDsS7iMXuk68ecFpPS9_qivuNPihXhy7E55o+GvoA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">
        <div dir="auto">igor，
          <div dir="auto">   I can test the patch if we have a package.</div>
          <div dir="auto">   My enviroment and workload can consistently
            reproduce the latency  2-3 days after restarting.</div>
          <div dir="auto">    Sage tells me to try bitmap allocator to
            make sure stupid allocator is the bad guy. I have some osds
            in luminous +bitmap and some osds in 14.1.0+bitmap.  Both
            looks positive till now, but i need more time to be sure.</div>
          <div dir="auto">     The perf ,log and admin socket analysis
            lead to the theory that in alloc_int the loop sometimes take
            long time wkth allocator locks held. Which blocks release
            part called from _txc_finish in kv_finalize_thread, this
            thread is also the one to calculate state_kv_committing_lat
            and overall commit_lat. You can find from admin socket that
            state_done_latency has similar trend as commit_latency.</div>
              But we cannot find a theory to.explain why reboot helps,
          the allocator btree will be rebuild from freelist manager
          and.it.should be exactly. the same as it is prior to reboot. 
           Anything related with pg recovery?</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">   Anyway, as I have a live env and workload, I
          am more than willing to work with you for further
          investigatiom</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">-Xiaoxi</div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr">Igor Fedotov &lt;<a
              href="mailto:ifedotov-l3A5Bk7waGM@public.gmane.org" target="_blank"
              rel="noreferrer" moz-do-not-send="true">ifedotov-l3A5Bk7waGM@public.gmane.org</a>&gt;
            于 2019年3月1日周五 上午6:21写道：<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">Also I
            think it makes sense to create a ticket at this point. Any <br>
            volunteers?<br>
            <br>
            On 3/1/2019 1:00 AM, Igor Fedotov wrote:<br>
            &gt; Wondering if somebody would be able to apply simple
            patch that <br>
            &gt; periodically resets StupidAllocator?<br>
            &gt;<br>
            &gt; Just to verify/disprove the hypothesis it's allocator
            relateted<br>
            &gt;<br>
            &gt; On 2/28/2019 11:57 PM, Stefan Kooman wrote:<br>
            &gt;&gt; Quoting Wido den Hollander (<a
              href="mailto:wido-fspyXLx8qC4@public.gmane.org" rel="noreferrer noreferrer"
              target="_blank" moz-do-not-send="true">wido-fspyXLx8qC4@public.gmane.org</a>):<br>
            &gt;&gt;&gt; Just wanted to chime in, I've seen this with
            Luminous+BlueStore+NVMe<br>
            &gt;&gt;&gt; OSDs as well. Over time their latency increased
            until we started to<br>
            &gt;&gt;&gt; notice I/O-wait inside VMs.<br>
            &gt;&gt; On a Luminous 12.2.8 cluster with only SSDs we also
            hit this issue I<br>
            &gt;&gt; guess. After restarting the OSD servers the latency
            would drop to normal<br>
            &gt;&gt; values again. See <a
              href="https://owncloud.kooman.org/s/BpkUc7YM79vhcDj"
              rel="noreferrer noreferrer noreferrer" target="_blank"
              moz-do-not-send="true">https://owncloud.kooman.org/s/BpkUc7YM79vhcDj</a><br>
            &gt;&gt;<br>
            &gt;&gt; Reboots were finished at ~ 19:00.<br>
            &gt;&gt;<br>
            &gt;&gt; Gr. Stefan<br>
            &gt;&gt;<br>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------4DACAD7450D8649415A83E64--

--===============5104475065458327088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============5104475065458327088==--
