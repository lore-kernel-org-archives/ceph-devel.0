From: Wei Jin <wjin.cn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: OSDs are flapping and marked down wrongly
Date: Mon, 17 Oct 2016 17:13:20 +0800
Message-ID: <CAPpSHbVR1W921Lx6xgg30L5KS_U+_bVSVW+c4h+c2-W7N1yXbg@mail.gmail.com>
References: <BY2PR02MB3964B80170065D0141B7931F4D00@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <BY2PR02MB3964B80170065D0141B7931F4D00-USF8g7QUirCbDkdw+1LTknlDjJuWSFo1XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Oct 17, 2016 at 3:16 PM, Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org> wrote:
> Hi Sage et. al,
>
> I know this issue is reported number of times in community and attributed to either network issue or unresponsive OSDs.
> Recently, we are seeing this issue when our all SSD cluster (Jewel based)  is stressed with large block size and very high QD. Lowering QD it is working just fine.
> We are seeing the lossy connection message like below and followed by the osd marked down by monitor.
>
> 2016-10-15 14:30:13.957534 7f6297bff700  0 -- 10.10.10.94:6810/2461767 submit_message osd_op_reply(1463 rbd_data.55246b8b4567.000000000000d633 [set-alloc-hint object_size 4194304 write_size 4194304,write 3932160~262144] v222'95890 uv95890 ondisk = 0) v7 remote, 10.10.10.98:0/1174431362, dropping message
>
> In the monitor log, I am seeing the osd is reported down by peers and subsequently monitor is marking it down.
> OSDs is rejoining the cluster after detecting it is marked down wrongly and rebalancing started. This is hurting performance very badly.

I think you need to tune threads' timeout values as heartbeat message
will be dropped during timeout and suicide (health check will fail).
That's why you observe 'wrongly marked me down' message but osd
process is still alive. See function OSD::handle_osd_ping()

Also, you could backport this
pr(https://github.com/ceph/ceph/pull/8808) to accelerate dealing with
heartbeat message.

After that, you may consider tuning grace time.


>
> My question is the following.
>
> 1. I have 40Gb network and I am seeing network is not utilized beyond 10-12Gb/s , no network error is reported. So, why this lossy connection message is coming ? what could go wrong here ? Is it network prioritization issue of smaller ping packets ? I tried to gaze ping round time during this and nothing seems abnormal.
>
> 2. Nothing is saturated on the OSD side , plenty of network/memory/cpu/disk is left. So, I doubt my osds are unresponsive but yes it is really busy on IO path. Heartbeat is going through separate messenger and threads as well, so, busy op threads should not be making heartbeat delayed. Increasing osd heartbeat grace is only delaying this phenomenon , but, eventually happens after several hours. Anything else we can tune here ?
>
> 3. What could be the side effect of big grace period ? I understand that detecting a faulty osd will be delayed, anything else ?
>
> 4. I saw if an OSD is crashed, monitor will detect the down osd almost instantaneously and it is not waiting till this grace period. How it is distinguishing between unresponsive and crashed osds ? In which scenario this heartbeat grace is coming into picture ?
>
> Any help on clarifying this would be very helpful.
>
> Thanks & Regards
> Somnath
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
