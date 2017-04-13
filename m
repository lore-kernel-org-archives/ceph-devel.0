From: Andras Pataki <apataki-KOQ3cyhuqtcyYCB5lekE3M0vGNN6ct63@public.gmane.org>
Subject: Re: fsping, why you no work no mo?
Date: Thu, 13 Apr 2017 15:20:10 -0400
Message-ID: <f2489e07-dd13-0299-a90e-97f1072a525d@flatironinstitute.org>
References: <CABZ+qqnUUxq-OVTs6MFYVqnDZdmWqPzq0TjCePAjZtnKGD0E-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0456868682=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABZ+qqnUUxq-OVTs6MFYVqnDZdmWqPzq0TjCePAjZtnKGD0E-w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============0456868682==
Content-Type: multipart/alternative;
 boundary="------------206518BAE052F0903FC45AB2"

This is a multi-part message in MIME format.
--------------206518BAE052F0903FC45AB2
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dan,

I don't have a solution to the problem, I can only second that we've 
also been seeing strange problems when more than one node accesses the 
same file in ceph and at least one of them opens it for writing.  I've 
tried verbose logging on the client (fuse), and it seems that the fuse 
client sends some cap request to the MDS and does not get a response 
sometimes.  And it looks like it has some 5 second polling interval, and 
that sometimes (but not always) saves the day and the client continues 
with a 5 second-ish delay.  This does not happen when multiple processes 
open the file for reading, but it does when processes open it for 
writing (even if they never write to the file and only read 
afterwards).  I have some earlier mailing list messages from a week or 
two ago describing what we see more in detail (including log outputs).  
I think the issue has in some way to do with cap requests being 
lost/miscommunicated between the client and the MDS.

Andras


On 04/13/2017 01:41 PM, Dan van der Ster wrote:
> Dear ceph-*,
>
> A couple weeks ago I wrote this simple tool to measure the round-trip 
> latency of a shared filesystem.
>
> https://github.com/dvanders/fsping
>
> In our case, the tool is to be run from two clients who mount the same 
> CephFS.
>
> First, start the server (a.k.a. the ping reflector) on one machine in 
> a CephFS directory:
>
>    ./fsping --server
>
> Then, from another client machine and in the same directory, start the 
> fsping client (aka the ping emitter):
>
>     ./fsping --prefix <prefix from the server above>
>
> The idea is that the "client" writes a syn file, the reflector notices 
> it, and writes an ack file. The time for the client to notice the ack 
> file is what I call the rtt.
>
> And the output looks like normal ping, so that's neat. (The README.md 
> shows a working example)
>
>
> Anyway, two weeks ago when I wrote this, it was working very well on 
> my CephFS clusters (running 10.2.5, IIRC). I was seeing ~20ms rtt for 
> small files, which is more or less what I was expecting on my test 
> cluster.
>
> But when I run fsping today, it does one of two misbehaviours:
>
>   1. Most of the time it just hangs, both on the reflector and on the 
> emitter. The fsping processes are stuck in some uninterruptible state 
> -- only an MDS failover breaks them out. I tried with and without 
> fuse_disable_pagecache -- no big difference.
>
>   2. When I increase the fsping --size to 512kB, it works a bit more 
> reliably. But there is a weird bimodal distribution with most 
> "packets" having 20-30ms rtt, some ~20% having ~5-6 seconds rtt, and 
> some ~5% taking ~10-11s. I suspected the mds_tick_interval -- but 
> decreasing that didn't help.
>
>
> In summary, if someone is curious, please give this tool a try on your 
> CephFS cluster -- let me know if its working or not (and what rtt you 
> can achieve with which configuration).
> And perhaps a dev would understand why it is not working with latest 
> jewel ceph-fuse / ceph MDS's?
>
> Best Regards,
>
> Dan
>
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


--------------206518BAE052F0903FC45AB2
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi Dan,<br>
    <br>
    I don't have a solution to the problem, I can only second that we've
    also been seeing strange problems when more than one node accesses
    the same file in ceph and at least one of them opens it for
    writing.  I've tried verbose logging on the client (fuse), and it
    seems that the fuse client sends some cap request to the MDS and
    does not get a response sometimes.  And it looks like it has some 5
    second polling interval, and that sometimes (but not always) saves
    the day and the client continues with a 5 second-ish delay.  This
    does not happen when multiple processes open the file for reading,
    but it does when processes open it for writing (even if they never
    write to the file and only read afterwards).  I have some earlier
    mailing list messages from a week or two ago describing what we see
    more in detail (including log outputs).  I think the issue has in
    some way to do with cap requests being lost/miscommunicated between
    the client and the MDS.<br>
    <br>
    Andras<br>
    <br>
    <br>
    <div class="moz-cite-prefix">On 04/13/2017 01:41 PM, Dan van der
      Ster wrote:<br>
    </div>
    <blockquote
cite="mid:CABZ+qqnUUxq-OVTs6MFYVqnDZdmWqPzq0TjCePAjZtnKGD0E-w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
      type="cite">
      <div dir="ltr">Dear ceph-*,<br>
        <br>
        A couple weeks ago I wrote this simple tool to measure the
        round-trip latency of a shared filesystem.<br>
        <br>
           <a moz-do-not-send="true"
          href="https://github.com/dvanders/fsping">https://github.com/dvanders/fsping</a><br>
        <br>
        In our case, the tool is to be run from two clients who mount
        the same CephFS.<br>
        <br>
        First, start the server (a.k.a. the ping reflector) on one
        machine in a CephFS directory:<br>
        <br>
           ./fsping --server<br>
        <br>
        Then, from another client machine and in the same directory,
        start the fsping client (aka the ping emitter):<br>
        <br>
            ./fsping --prefix &lt;prefix from the server above&gt;<br>
        <br>
        The idea is that the "client" writes a syn file, the reflector
        notices it, and writes an ack file. The time for the client to
        notice the ack file is what I call the rtt.<br>
        <br>
        And the output looks like normal ping, so that's neat. (The
        README.md shows a working example)<br>
        <br>
        <br>
        Anyway, two weeks ago when I wrote this, it was working very
        well on my CephFS clusters (running 10.2.5, IIRC). I was seeing
        ~20ms rtt for small files, which is more or less what I was
        expecting on my test cluster.<br>
        <br>
        But when I run fsping today, it does one of two misbehaviours:<br>
        <br>
          1. Most of the time it just hangs, both on the reflector and
        on the emitter. The fsping processes are stuck in some
        uninterruptible state -- only an MDS failover breaks them out. I
        tried with and without fuse_disable_pagecache -- no big
        difference.<br>
        <br>
          2. When I increase the fsping --size to 512kB, it works a bit
        more reliably. But there is a weird bimodal distribution with
        most "packets" having 20-30ms rtt, some ~20% having ~5-6 seconds
        rtt, and some ~5% taking ~10-11s. I suspected the
        mds_tick_interval -- but decreasing that didn't help.<br>
        <br>
        <br>
        In summary, if someone is curious, please give this tool a try
        on your CephFS cluster -- let me know if its working or not (and
        what rtt you can achieve with which configuration).<br>
        And perhaps a dev would understand why it is not working with
        latest jewel ceph-fuse / ceph MDS's?
        <div><br>
        </div>
        <div>Best Regards,</div>
        <div><br>
        </div>
        <div>Dan</div>
        <div><br>
        </div>
        <div><br>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
ceph-users mailing list
<a class="moz-txt-link-abbreviated" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------206518BAE052F0903FC45AB2--

--===============0456868682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0456868682==--
