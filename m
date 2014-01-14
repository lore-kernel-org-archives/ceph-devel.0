From: Guang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Ceph cluster is unreachable because of
	authentication failure
Date: Wed, 15 Jan 2014 05:54:31 +0800
Message-ID: <BLU0-SMTP102FD05B2E9B9AE3A13557EDFBF0@phx.gbl>
References: <BLU0-SMTP1356EEDE6A8ACF94947F22ADFBF0@phx.gbl>
	<alpine.DEB.2.00.1401140654500.10628@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1401140654500.10628-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Thanks Sage.

-bash-4.1$ sudo ceph --admin-daemon /var/run/ceph/ceph-mon.osd151.asok mon_status
{ "name": "osd151",
  "rank": 2,
  "state": "electing",
  "election_epoch": 85469,
  "quorum": [],
  "outside_quorum": [],
  "extra_probe_peers": [],
  "sync_provider": [],
  "monmap": { "epoch": 1,
      "fsid": "b9cb3ea9-e1de-48b4-9e86-6921e2c537d2",
      "modified": "0.000000",
      "created": "0.000000",
      "mons": [
            { "rank": 0,
              "name": "osd152",
              "addr": "10.193.207.130:6789\/0"},
            { "rank": 1,
              "name": "osd153",
              "addr": "10.193.207.131:6789\/0"},
            { "rank": 2,
              "name": "osd151",
              "addr": "10.194.0.68:6789\/0"}]}}

And:

-bash-4.1$ sudo ceph --admin-daemon /var/run/ceph/ceph-mon.osd151.asok quorum_status
{ "election_epoch": 85480,
  "quorum": [
        0,
        1,
        2],
  "quorum_names": [
        "osd151",
        "osd152",
        "osd153"],
  "quorum_leader_name": "osd152",
  "monmap": { "epoch": 1,
      "fsid": "b9cb3ea9-e1de-48b4-9e86-6921e2c537d2",
      "modified": "0.000000",
      "created": "0.000000",
      "mons": [
            { "rank": 0,
              "name": "osd152",
              "addr": "10.193.207.130:6789\/0"},
            { "rank": 1,
              "name": "osd153",
              "addr": "10.193.207.131:6789\/0"},
            { "rank": 2,
              "name": "osd151",
              "addr": "10.194.0.68:6789\/0"}]}}


The election has been finished with leader selected from the above status.

Thanks,
Guang

On Jan 14, 2014, at 10:55 PM, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> On Tue, 14 Jan 2014, GuangYang wrote:
>> Hi ceph-users and ceph-devel,
>> I came across an issue after restarting monitors of the cluster, that authentication fails which prevents running any ceph command.
>> 
>> After we did some maintenance work, I restart OSD, however, I found that the OSD would not join the cluster automatically after being restarted, though TCP dump showed it had already sent messenger to monitor telling add me into the cluster.
>> 
>> So that I suspected there might be some issues of monitor and I restarted monitor one by one (3 in total), however, after restarting monitors, all ceph command would fail saying authentication timeout?
>> 
>> 2014-01-14 12:00:30.499397 7fc7f195e700  0 monclient(hunting): authenticate timed out after 300
>> 2014-01-14 12:00:30.499440 7fc7f195e700  0 librados: client.admin authentication error (110) Connection timed out
>> Error connecting to cluster: Error
>> 
>> Any idea why such error happened (restarting OSD would result in the same error)?
>> 
>> I am thinking the authentication information is persisted in mon local disk and is there a chance those data got corrupted?
> 
> That sounds unlikely, but you're right that the core problem is with the 
> mons.  What does 
> 
> ceph daemon mon.`hostname` mon_status
> 
> say?  Perhaps they are not forming a quorum and that is what is preventing 
> authentication.
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
