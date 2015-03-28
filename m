From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: 0.93 fresh cluster won't create PGs
Date: Fri, 27 Mar 2015 21:03:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503272057160.18934@cobra.newdream.net>
References: <CAANLjFo8j_Xhn2x86ZdsH7dwTB+_=mfWBh9icVF+9FvK3V4Tfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAANLjFo8j_Xhn2x86ZdsH7dwTB+_=mfWBh9icVF+9FvK3V4Tfg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, 27 Mar 2015, Robert LeBlanc wrote:
> I've built Ceph clusters a few times now and I'm completely baffled
> about what we are seeing. We had a majority of the nodes on a new
> cluster go down yesterday and we got PGs stuck peering. We checked
> logs, firewalls, file descriptors, etc and nothing is pointing to what
> the problem is. We thought we could work around the problem by
> deleting all the pools and recreating them, but still most of the PGs
> were in a creating+peering state. Rebooting OSDs, reformatting them,
> adjusting the CRUSH, etc all proved fruitless. I took min_size and
> size to 1, tried scrubbing, deep-scrubbing the PGs and OSDs. Nothing
> seems to get the cluster to progress.
> 
> As a last ditch effort, we wiped the whole cluster, regenerated UUID,
> keys, etc and pushed it all through puppet again. After creating the
> OSDs there are PGs stuck. Here is some info:
> 
> [ulhglive-root@mon1 ~]# ceph status
>     cluster fa158fa8-3e5d-47b1-a7bc-98a41f510ac0
>      health HEALTH_WARN
>             1214 pgs peering
>             1216 pgs stuck inactive
>             1216 pgs stuck unclean
>      monmap e2: 3 mons at
> {mon1=10.217.72.27:6789/0,mon2=10.217.72.28:6789/0,mon3=10.217.72.29:6789/0}
>             election epoch 6, quorum 0,1,2 mon1,mon2,mon3
>      osdmap e161: 130 osds: 130 up, 130 in
>       pgmap v468: 2048 pgs, 2 pools, 0 bytes data, 0 objects
>             5514 MB used, 472 TB / 472 TB avail
>                  965 peering
>                  832 active+clean
>                  249 creating+peering
>                    2 activating

Usually when we've seen something like this is has been something annoying 
with the environment, like a broken network that causes the tcp streams to 
freeze once they start sending significant traffic (e.g., affecting the 
connections that transpart data but not the ones that handle heartbeats).

As you're rebuilding, perhaps the issues start once you hit a particular 
rack or host?

> [ulhglive-root@mon1 ~]# ceph health detail | head -n 15
> HEALTH_WARN 1214 pgs peering; 1216 pgs stuck inactive; 1216 pgs stuck unclean
> pg 2.17f is stuck inactive since forever, current state
> creating+peering, last acting [39,42,77]
> pg 2.17e is stuck inactive since forever, current state
> creating+peering, last acting [125,3,110]
> pg 2.179 is stuck inactive since forever, current state peering, last acting [0]
> pg 2.178 is stuck inactive since forever, current state
> creating+peering, last acting [99,120,54]
> pg 2.17b is stuck inactive since forever, current state peering, last acting [0]
> pg 2.17a is stuck inactive since forever, current state
> creating+peering, last acting [91,96,122]
> pg 2.175 is stuck inactive since forever, current state
> creating+peering, last acting [55,127,2]
> pg 2.174 is stuck inactive since forever, current state peering, last acting [0]
> pg 2.176 is stuck inactive since forever, current state
> creating+peering, last acting [13,70,8]
> pg 2.172 is stuck inactive since forever, current state peering, last acting [0]
> pg 2.16c is stuck inactive for 1344.369455, current state peering,
> last acting [99,104,85]
> pg 2.16e is stuck inactive since forever, current state peering, last acting [0]
> pg 2.169 is stuck inactive since forever, current state
> creating+peering, last acting [125,24,65]
> pg 2.16a is stuck inactive since forever, current state peering, last acting [0]
> Traceback (most recent call last):
>   File "/bin/ceph", line 896, in <module>
>     retval = main()
>   File "/bin/ceph", line 883, in main
>     sys.stdout.write(prefix + outbuf + suffix)
> IOError: [Errno 32] Broken pipe
> [ulhglive-root@mon1 ~]# ceph pg dump_stuck | head -n 15
> ok
> pg_stat state   up      up_primary      acting  acting_primary
> 2.17f   creating+peering        [39,42,77]      39      [39,42,77]      39
> 2.17e   creating+peering        [125,3,110]     125     [125,3,110]     125
> 2.179   peering [0]     0       [0]     0
> 2.178   creating+peering        [99,120,54]     99      [99,120,54]     99
> 2.17b   peering [0]     0       [0]     0
> 2.17a   creating+peering        [91,96,122]     91      [91,96,122]     91
> 2.175   creating+peering        [55,127,2]      55      [55,127,2]      55
> 2.174   peering [0]     0       [0]     0
> 2.176   creating+peering        [13,70,8]       13      [13,70,8]       13
> 2.172   peering [0]     0       [0]     0
> 2.16c   peering [99,104,85]     99      [99,104,85]     99
> 2.16e   peering [0]     0       [0]     0
> 2.169   creating+peering        [125,24,65]     125     [125,24,65]     125
> 2.16a   peering [0]     0       [0]     0
> 
> Focusing on 2.17f on OSD 39, I set debugging to 20/20 and am attaching
> the logs. I've looked through the logs with 20/20 before we toasted
> the cluster and I couldn't find anything standing out. I have another
> cluster that is also exhibiting this problem which I'd prefer not to
> lose the data on. If anything stands out, please let me know. We are
> going to wipe this cluster again and take more manual steps.
> 
> ceph-osd.39.log.xz -
> https://owncloud.leblancnet.us/owncloud/public.php?service=files&t=b120a67cc6111ffcba54d2e4cc8a62b5
> map.xz - https://owncloud.leblancnet.us/owncloud/public.php?service=files&t=df1eecf7d307225b7d43b5c9474561d0

It looks liek this particular PG isn't getting a query response from 
osd.39 and osd.42.  The 'ceph pg 2.17f query' will likely tell you 
something similar that it is trying to get info from those OSDs.  If you 
crank up debug ms = 20 you'll be able watch it try to connect and send 
messages to those peers as well, and if you have logging on the other 
end you can see if the message arrives or not.

It's also possible that this is a bug in 0.93 that we've fixed (there have 
been tons of those); before investing too much effort I would try 
installing the latest hammer branch from the gitbuilders as that's 
very very close to what will be released next week.

Hope that helps!
sage


> 
> 
> After redoing the cluster again, we started slow. We added one OSD,
> dropped the pools to min_size=1 and size=1, and the cluster became
> healthy. We added a second OSD and changed the CRUSH rule to OSD and
> it became healthy again. We change size=3 and min_size=2. We had
> puppet add 10 OSDs on one host, and waited, the cluster became healthy
> again. We had puppet add another host with 10 OSDs and waited for the
> cluster to become healthy again. We had puppet add the 8 remaining
> OSDs on the first host and the cluster became healthy again. We set
> the CRUSH rule back to host and the cluster became healthy again.
> 
> In order to test a theory we decided to kick off puppet on the
> remaining 10 hosts with 10 OSDs each at the same time (similar to what
> we did before). When about the 97th OSD was added, we started getting
> messages in ceph -w about stuck PGs and the cluster never became
> healthy.
> 
> I wonder if there are too many changes in too short of an amount of
> time causing the OSDs to overrun a journal or something (I know that
> Ceph journals pgmap changes and such). I'm concerned that this could
> be very detrimental in a production environment. There doesn't seem to
> be a way to recover from this.
> 
> Any thoughts?
> 
> Thanks,
> Robert LeBlanc
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
