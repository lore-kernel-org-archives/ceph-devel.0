From: Varada Kari <Varada.Kari-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Enclosure power failure pausing client IO till all
 connected hosts up
Date: Fri, 24 Jul 2015 02:01:04 +0000
Message-ID: <C226B0AB34511445928D9882AA519F601C45C9C5@SACMBXIP03.sdcorp.global.sandisk.com>
References: <CAEK_5WJV4UX-EMVed49RzKUpX-J7AsN=0gRBS5OpEPyPyjR+vA@mail.gmail.com>
	<CA+9C14ZjVMAs3mg+Vx3WZJSfW-bv0UOJyJvd=D8dUMaaujZn3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+9C14ZjVMAs3mg+Vx3WZJSfW-bv0UOJyJvd=D8dUMaaujZn3Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Eric Eastman <eric.eastman-yfee5r9JHcEqDJ6do+/SaQ@public.gmane.org>, Mallikarjun Biradar <mallikarjuna.biradar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

(Adding devel list to the CC)
Hi Eric,

To add more context to the problem:

Min_size was set to 1 and replication size is 2.

There was a flaky power connection to one of the enclosures.  With min_size 1, we were able to continue the IO's, and recovery was active once the power comes back. But if there is a power failure again when recovery is in progress, some of the PGs are going to down+peering state.

Extract from pg query.

$ ceph pg 1.143 query
{ "state": "down+peering",
  "snap_trimq": "[]",
  "epoch": 3918,
  "up": [
        17],
  "acting": [
        17],
  "info": { "pgid": "1.143",
      "last_update": "3166'40424",
      "last_complete": "3166'40424",
      "log_tail": "2577'36847",
      "last_user_version": 40424,
      "last_backfill": "MAX",
      "purged_snaps": "[]",

...... "recovery_state": [
        { "name": "Started\/Primary\/Peering\/GetInfo",
          "enter_time": "2015-07-15 12:48:51.372676",
          "requested_info_from": []},
        { "name": "Started\/Primary\/Peering",
          "enter_time": "2015-07-15 12:48:51.372675",
          "past_intervals": [
                { "first": 3147,
                  "last": 3166,
                  "maybe_went_rw": 1,
                  "up": [
                        17,
                        4],
                  "acting": [
                        17,
                        4],
                  "primary": 17,
                  "up_primary": 17},
                { "first": 3167,
                  "last": 3167,
                  "maybe_went_rw": 0,
                  "up": [
                        10,
                        20],
                  "acting": [
                        10,
                        20],
                  "primary": 10,
                  "up_primary": 10},
                { "first": 3168,
                  "last": 3181,
                  "maybe_went_rw": 1,
                  "up": [
                        10,
                        20],
                  "acting": [
                        10,
                        4],
                  "primary": 10,
                  "up_primary": 10},
                { "first": 3182,
                  "last": 3184,
                  "maybe_went_rw": 0,
                  "up": [
                        20],
                  "acting": [
                        4],
                  "primary": 4,
                  "up_primary": 20},
                { "first": 3185,
                  "last": 3188,
                  "maybe_went_rw": 1,
                  "up": [
                        20],
                  "acting": [
                        20],
                  "primary": 20,
                  "up_primary": 20}],
          "probing_osds": [
                "17",
                "20"],
          "blocked": "peering is blocked due to down osds",
          "down_osds_we_would_probe": [
                4,
                10],
          "peering_blocked_by": [
                { "osd": 4,
                  "current_lost_at": 0,
                  "comment": "starting or marking this osd lost may let us proceed"},
                { "osd": 10,
                  "current_lost_at": 0,
                  "comment": "starting or marking this osd lost may let us proceed"}]},
        { "name": "Started",
          "enter_time": "2015-07-15 12:48:51.372671"}],
  "agent_state": {}}

And Pgs are not coming to active+clean till power is resumed again. During this period no IOs are allowed to the cluster. Not able to follow why the PGs are ending up in peering state? Each Pg has two copies in both the enclosures. If one of enclosure is down for some time, should be able to serve IO's from the second one. That was true, if no recovery IO is involved. In case of any recovery, we are ending up some Pg's in down and peering state.

Thanks,
Varada


-----Original Message-----
From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of Eric Eastman
Sent: Thursday, July 23, 2015 8:37 PM
To: Mallikarjun Biradar <mallikarjuna.biradar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Subject: Re: [ceph-users] Enclosure power failure pausing client IO till all connected hosts up

You may want to check your min_size value for your pools.  If it is set to the pool size value, then the cluster will not do I/O if you loose a chassis.

On Sun, Jul 5, 2015 at 11:04 PM, Mallikarjun Biradar <mallikarjuna.biradar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi all,
>
> Setup details:
> Two storage enclosures each connected to 4 OSD nodes (Shared storage).
> Failure domain is Chassis (enclosure) level. Replication count is 2.
> Each host has allotted with 4 drives.
>
> I have active client IO running on cluster. (Random write profile with
> 4M block size & 64 Queue depth).
>
> One of enclosure had power loss. So all OSD's from hosts that are
> connected to this enclosure went down as expected.
>
> But client IO got paused. After some time enclosure & hosts connected
> to it came up.
> And all OSD's on that hosts came up.
>
> Till this time, cluster was not serving IO. Once all hosts & OSD's
> pertaining to that enclosure came up, client IO resumed.
>
>
> Can anybody help me why cluster not serving IO during enclosure
> failure. OR its a bug?
>
> -Thanks & regards,
> Mallikarjun Biradar
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
