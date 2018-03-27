From: KAMEI Hitoshi <hitoshi.kamei.xm@hitachi.com>
Subject: Re: Re: Re: Re: [PATCH 1/2] rbd: RBD_DEV_FLAG_THICK rbd_dev_flags
 bit
Date: Tue, 27 Mar 2018 18:44:30 +0900
Message-ID: <5ABA127E.5080601@hitachi.com>
References: <5AAFA682.2080901@hitachi.com> <5AB0E4F3.8090108@easystack.cn> <C8603108370B1949BF3CC7742DDE5D35B8B39FD9@GSjpTKYDCembx31.service.hitachi.net> <CAOi1vP8eLcc6u-XhpSu33+3eDygy3Mp+_tJXT7ygdwsnUs-RmQ@mail.gmail.com> <CAOi1vP_7La=nCs71wG3=HbYLaxM3uBFytv8pjGJLuR_uuB0GLg@mail.gmail.com> <C8603108370B1949BF3CC7742DDE5D35B8B42988@GSJPTKYDCEMBX32.service.hitachi.net> <CAOi1vP_qFkDK00-_KJpbrnC3PbP371=R4wxBH8gk2s47qwfrhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP_qFkDK00-_KJpbrnC3PbP371=R4wxBH8gk2s47qwfrhg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Dongsheng Yang <dongsheng.yang@easystack.cn>, "sage@redhat.com" <sage@redhat.com>, "elder@kernel.org" <elder@kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Hi Ilya,

Thank you for reviewing.
I merged two patches into one patch and pushed the new patch to GitHub.
And I opened the PR. Could you check the PR?

And I forgot to mention in previous email that I modified your patch to
apply the latest kernel because I couldn't apply your patch directly
by using git am command due to a little bit problem, and I tested
the kernel with the modified patch and rbd map command with notrim option.

The code described below is the modified patch by my hand.

Regards,

--- From here
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8e40da093766..c62e3788858c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -775,6 +775,7 @@ enum {
  	Opt_read_write,
  	Opt_lock_on_read,
  	Opt_exclusive,
+	Opt_notrim,
  	Opt_err
  };

@@ -788,6 +789,7 @@ static match_table_t rbd_opts_tokens = {
  	{Opt_read_write, "rw"},		/* Alternate spelling */
  	{Opt_lock_on_read, "lock_on_read"},
  	{Opt_exclusive, "exclusive"},
+	{Opt_notrim, "notrim"},
  	{Opt_err, NULL}
  };

@@ -796,12 +798,14 @@ struct rbd_options {
  	bool	read_only;
  	bool	lock_on_read;
  	bool	exclusive;
+	bool	trim;
  };

  #define RBD_QUEUE_DEPTH_DEFAULT	BLKDEV_MAX_RQ
  #define RBD_READ_ONLY_DEFAULT	false
  #define RBD_LOCK_ON_READ_DEFAULT false
  #define RBD_EXCLUSIVE_DEFAULT	false
+#define RBD_TRIM_DEFAULT	true

  static int parse_rbd_opts_token(char *c, void *private)
  {
@@ -843,6 +847,9 @@ static int parse_rbd_opts_token(char *c, void *private)
  	case Opt_exclusive:
  		rbd_opts->exclusive = true;
  		break;
+	case Opt_notrim:
+		rbd_opts->trim = false;
+		break;
  	default:
  		/* libceph prints "bad option" msg */
  		return -EINVAL;
@@ -4382,11 +4389,12 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
  	blk_queue_io_min(q, segment_size);
  	blk_queue_io_opt(q, segment_size);

-	/* enable the discard support */
-	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
-	q->limits.discard_granularity = segment_size;
-	blk_queue_max_discard_sectors(q, segment_size / SECTOR_SIZE);
-	blk_queue_max_write_zeroes_sectors(q, segment_size / SECTOR_SIZE);
+	if (rbd_dev->opts->trim) {
+		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
+		q->limits.discard_granularity = segment_size;
+		blk_queue_max_discard_sectors(q, segment_size / SECTOR_SIZE);
+		blk_queue_max_write_zeroes_sectors(q, segment_size / SECTOR_SIZE);
+	}

  	if (!ceph_test_opt(rbd_dev->rbd_client->client, NOCRC))
  		q->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
@@ -5637,6 +5645,7 @@ static int rbd_add_parse_args(const char *buf,
  	rbd_opts->queue_depth = RBD_QUEUE_DEPTH_DEFAULT;
  	rbd_opts->lock_on_read = RBD_LOCK_ON_READ_DEFAULT;
  	rbd_opts->exclusive = RBD_EXCLUSIVE_DEFAULT;
+	rbd_opts->trim = RBD_TRIM_DEFAULT;

  	copts = ceph_parse_options(options, mon_addrs,
  					mon_addrs + mon_addrs_size - 1,
--- To here

--
Hitoshi Kamei
