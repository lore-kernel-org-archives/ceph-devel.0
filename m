From: Gregory Farnum <greg@inktank.com>
Subject: Re: MDS can't join in
Date: Tue, 3 Dec 2013 09:34:32 -0800
Message-ID: <CAPYLRzhqLwKbMYcdtAU2m7ZpHAnH5VusDBkBLyfpXuaMs8dvFQ@mail.gmail.com>
References: <7061367AB47B6A4EAE551551A9A197330100F96F@S3-EXCHMB04.shared-svc.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36657 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102Ab3LCRed convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Dec 2013 12:34:33 -0500
Received: by mail-wi0-f182.google.com with SMTP id en1so6880077wid.9
        for <ceph-devel@vger.kernel.org>; Tue, 03 Dec 2013 09:34:32 -0800 (PST)
In-Reply-To: <7061367AB47B6A4EAE551551A9A197330100F96F@S3-EXCHMB04.shared-svc.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Luo Shaobo (DSI)" <luosb@dsi.a-star.edu.sg>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Does the MDS have access to a keyring which contains its key, and does
that match what's on the monitor? You're just referring to the
client.admin one, which it won't use (it's not a client). It certainly
looks like there's a mismatch based on the verification error.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Mon, Dec 2, 2013 at 5:31 PM, Luo Shaobo (DSI)
<luosb@dsi.a-star.edu.sg> wrote:
> Dear All,
>
> I have updated a new version of Ceph, but I meet some strange things. It seems that MDS does not join the cluster.
>
> In the manager node, there no MDS in. and the log of ceph_mds  shows error during decoding block for decryption. But all the configuration on all the node are same.
>
> 1.  sudo cat /etc/ceph/ceph.client.admin.keyring
> [client.admin]
>         key = AQADa5xSCNRIIRAA/wPhnf+opgCFfwVFQTI0sg==
>
> 2. sudo cat /etc/ceph/ceph.conf
> [global]
> fsid = fc446df6-cc65-4ae8-8508-9eb8db6ad922
> mon_initial_members = ubuntu217
> mon_host = 192.168.36.217
> auth_supported = cephx
> osd_journal_size = 1024
> filestore_xattr_use_omap = true
>
> 3. ceph mds dump.
> dumped mdsmap epoch 32
> epoch   32
> flags   0
> created 2013-12-02 19:12:02.932374
> modified        2013-12-03 18:13:03.363896
> tableserver     0
> root    0
> session_timeout 60
> session_autoclose       300
> last_failure    0
> last_failure_osd_epoch  19
> compat  compat={},rocompat={},incompat={1=base v0.20,2=client writeable ranges,3=default file layouts on dirs,4=dir inode in separate object,5=mds uses versioned encoding}
> max_mds 1
> in      0
> up      {0=4322}
> failed
> stopped
> data_pools      0
> metadata_pool   1
> 4322:   192.168.36.217:6800/2507 'ubuntu217' mds.0.6 up:replay seq 1 laggy since 2013-12-03 18:09:18.277255
>
> 4. ceph-mds process log.
>
> ceph@ubuntu217:~$ sudo /usr/bin/ceph-mds --cluster=ceph -i ubuntu217 -d
> 2013-12-03 18:08:55.210327 7f30827a5780  0 starting mds.ubuntu217 at :/ceph version 0.72.1 (4d923861868f6a15dcb33fef7f50f674997322de), process ceph-mds, pid 2507
> 0
> 2013-12-03 18:08:55.235122 7f307d838700  1 mds.0.6 handle_mds_map i am now mds.0.6
> 2013-12-03 18:08:55.235125 7f307d838700  1 mds.0.6 handle_mds_map state change up:boot --> up:replay
> 2013-12-03 18:08:55.235135 7f307d838700  1 mds.0.6 replay_start
> 2013-12-03 18:08:55.235139 7f307d838700  1 mds.0.6  recovery set is
> 2013-12-03 18:08:55.235141 7f307d838700  1 mds.0.6  need osdmap epoch 19, have 19
> 2013-12-03 18:08:55.237000 7f307a630700  0 cephx: verify_reply couldn't decrypt with error: error decoding block for decryption
> 2013-12-03 18:08:55.237028 7f307a630700  0 -- 192.168.36.217:6800/2507 >> 192.168.35.82:6800/7500 pipe(0x298b500 sd=16 :48150 s=1 pgs=0 cs=0 l=1 c=0x2958840).failed verifying authorize reply
> 2013-12-03 18:08:55.237083 7f307a630700  0 -- 192.168.36.217:6800/2507 >> 192.168.35.82:6800/7500 pipe(0x298b500 sd=16 :48150 s=1 pgs=0 cs=0 l=1 c=0x2958840).fault
>
> ________________________________
> This email and any attachments are confidential and may be privileged. If you are not the intended recipient, please delete it and notify us immediately. Please do not copy or use it for any purpose, or disclose its contents to any other person. This email does not constitute a contract offer, a contract amendment, or an acceptance of a contract offer. Thank you.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
