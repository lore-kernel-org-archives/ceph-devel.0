From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: IMPORTANT: Help: CephFS: FSCache: Multiple "user" mounts: leads
 to kernel crash always
Date: Mon, 26 Jun 2017 21:39:28 +0800
Message-ID: <6A7CECC8-65C1-4C8A-97B5-3663FB978126@redhat.com>
References: <1526449060.8319671.1497356505353.ref@mail.yahoo.com>
 <1526449060.8319671.1497356505353@mail.yahoo.com>
 <CANP1eJEzrt4VNvVghv81myiWdr=afY2Q8wESZUG1QfcLxUQrMw@mail.gmail.com>
 <1575453992.8635991.1497379073685@mail.yahoo.com>
 <1837992712.9057824.1497412489358@mail.yahoo.com>
 <93F8A0A5-0565-4E18-B8ED-25BBBF9E1982@redhat.com>
 <1398535033.1364189.1498138854902@mail.yahoo.com>
 <CANP1eJEJhaQS0mjTXo3m83f=MuXZVMjFKsxdG1nPOCjOdwwm8g@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_86A6265E-7341-4C5E-B64E-9C626040C27D"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752165AbdFZNjT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 26 Jun 2017 09:39:19 -0400
In-Reply-To: <CANP1eJEJhaQS0mjTXo3m83f=MuXZVMjFKsxdG1nPOCjOdwwm8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: Anish Gupta <anish_gupta@yahoo.com>, Sage Weil <sweil@redhat.com>, David Howells <dhowells@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>


--Apple-Mail=_86A6265E-7341-4C5E-B64E-9C626040C27D
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On 22 Jun 2017, at 21:45, Milosz Tanski <milosz@adfin.com> wrote:
> 
> Looking at this again & and your fix Yan.
> 
> The cache should not be keyed by session-id; it should be keyed by
> filesystem. FScache is meant to work across reboots and I've
> implemented it in Ceph for our original use case it does.
> 
> A good example is we're serving data out of cephfs but hardly ever hit
> Ceph 10% of the time. We have large (2TB nvme) caches in front of
> it... and it would take too long time rebuild them when the machine
> reboots for updates.
> 


--Apple-Mail=_86A6265E-7341-4C5E-B64E-9C626040C27D
Content-Disposition: attachment;
	filename=ceph_fscache.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="ceph_fscache.patch"
Content-Transfer-Encoding: 7bit

diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 4e7421c..663e92e 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -35,8 +35,17 @@ struct fscache_netfs ceph_cache_netfs = {
 	.version	= 0,
 };
 
-static uint16_t ceph_fscache_session_get_key(const void *cookie_netfs_data,
-					     void *buffer, uint16_t maxbuf)
+static DEFINE_MUTEX(ceph_fscache_fsid_lock);
+static LIST_HEAD(ceph_fscache_fsid_list);
+
+struct ceph_fscache_fsid {
+	struct list_head list;
+	struct fscache_cookie *fscache;
+	struct ceph_fsid fsid;
+};
+
+static uint16_t ceph_fscache_fsid_get_key(const void *cookie_netfs_data,
+					  void *buffer, uint16_t maxbuf)
 {
 	const struct ceph_fs_client* fsc = cookie_netfs_data;
 	uint16_t klen;
@@ -52,7 +61,32 @@ static uint16_t ceph_fscache_session_get_key(const void *cookie_netfs_data,
 static const struct fscache_cookie_def ceph_fscache_fsid_object_def = {
 	.name		= "CEPH.fsid",
 	.type		= FSCACHE_COOKIE_TYPE_INDEX,
-	.get_key	= ceph_fscache_session_get_key,
+	.get_key	= ceph_fscache_fsid_get_key,
+};
+
+static uint16_t ceph_fscache_client_get_key(const void *cookie_netfs_data,
+					    void *buffer, uint16_t maxbuf)
+{
+	const struct ceph_fs_client* fsc = cookie_netfs_data;
+	const struct ceph_fsid *fsid = &fsc->client->fsid;
+	u64 client_id = fsc->client->monc.auth->global_id;
+	uint16_t fsid_len, key_len;
+
+	fsid_len = sizeof(*fsid);
+	key_len = fsid_len + sizeof(client_id);
+	if (key_len > maxbuf)
+		return 0;
+
+	memcpy(buffer, fsid, fsid_len);
+	memcpy(buffer + fsid_len, &client_id, sizeof(client_id));
+
+	return key_len;
+}
+
+static const struct fscache_cookie_def ceph_fscache_client_object_def = {
+	.name		= "CEPH.client",
+	.type		= FSCACHE_COOKIE_TYPE_INDEX,
+	.get_key	= ceph_fscache_client_get_key,
 };
 
 int ceph_fscache_register(void)
@@ -65,15 +99,51 @@ void ceph_fscache_unregister(void)
 	fscache_unregister_netfs(&ceph_cache_netfs);
 }
 
-int ceph_fscache_register_fs(struct ceph_fs_client* fsc)
+int ceph_fscache_register_fs(struct ceph_fs_client* fsc, bool tmp)
 {
-	fsc->fscache = fscache_acquire_cookie(ceph_cache_netfs.primary_index,
-					      &ceph_fscache_fsid_object_def,
-					      fsc, true);
-	if (!fsc->fscache)
-		pr_err("Unable to register fsid: %p fscache cookie\n", fsc);
+	const struct ceph_fsid *fsid = &fsc->client->fsid;
+	struct ceph_fscache_fsid *ent;
+	int err = 0;
+
+	if (tmp) {
+		fsc->fscache = fscache_acquire_cookie(ceph_cache_netfs.primary_index,
+						      &ceph_fscache_client_object_def,
+						      fsc, true);
+		if (!fsc->fscache)
+			pr_err("Unable to register fsid: %p fscache cookie\n", fsc);
+	} else {
+		mutex_lock(&ceph_fscache_fsid_lock);
+		list_for_each_entry(ent, &ceph_fscache_fsid_list, list) {
+			if (!memcmp(&ent->fsid, fsid, sizeof(*fsid))) {
+				pr_err("An fscache cookie already registered for fsid %pU\n", fsid);
+				pr_err("\tuse tmpfsc mount option instead\n");
+				err = -EBUSY;
+				goto out_unlock;
+			}
+		}
 
-	return 0;
+		ent = kzalloc(sizeof(*ent), GFP_KERNEL);
+		if (!ent) {
+			err = -ENOMEM;
+			goto out_unlock;
+		}
+
+		fsc->fscache = fscache_acquire_cookie(ceph_cache_netfs.primary_index,
+						      &ceph_fscache_fsid_object_def,
+						      fsc, true);
+
+		if (fsc->fscache) {
+			memcpy(&ent->fsid, fsid, sizeof(*fsid));
+			ent->fscache = fsc->fscache;
+			list_add_tail(&ent->list, &ceph_fscache_fsid_list);
+		} else {
+			kfree(ent);
+			pr_err("Unable to register fsid: %p fscache cookie\n", fsc);
+		}
+out_unlock:
+		mutex_unlock(&ceph_fscache_fsid_lock);
+	}
+	return err;
 }
 
 static uint16_t ceph_fscache_inode_get_key(const void *cookie_netfs_data,
@@ -349,7 +419,29 @@ void ceph_invalidate_fscache_page(struct inode* inode, struct page *page)
 
 void ceph_fscache_unregister_fs(struct ceph_fs_client* fsc)
 {
-	fscache_relinquish_cookie(fsc->fscache, 0);
+	if (fscache_cookie_valid(fsc->fscache)) {
+		if (fsc->fscache->def == &ceph_fscache_fsid_object_def) {
+			const struct ceph_fsid *fsid = &fsc->client->fsid;
+			struct ceph_fscache_fsid *ent, *found = NULL;
+
+			mutex_lock(&ceph_fscache_fsid_lock);
+			list_for_each_entry(ent, &ceph_fscache_fsid_list, list) {
+				if (!memcmp(&ent->fsid, fsid, sizeof(*fsid))) {
+					found = ent;
+					break;
+				}
+			}
+			if (found) {
+				WARN_ON_ONCE(found->fscache != fsc->fscache);
+				list_del(&found->list);
+				kfree(found);
+			} else {
+				WARN_ON_ONCE(true);
+			}
+			mutex_unlock(&ceph_fscache_fsid_lock);
+		}
+		__fscache_relinquish_cookie(fsc->fscache, 0);
+	}
 	fsc->fscache = NULL;
 }
 
diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index 7e72c75..f6afdde 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -31,7 +31,7 @@ extern struct fscache_netfs ceph_cache_netfs;
 int ceph_fscache_register(void);
 void ceph_fscache_unregister(void);
 
-int ceph_fscache_register_fs(struct ceph_fs_client* fsc);
+int ceph_fscache_register_fs(struct ceph_fs_client* fsc, bool tmp);
 void ceph_fscache_unregister_fs(struct ceph_fs_client* fsc);
 
 void ceph_fscache_register_inode_cookie(struct inode *inode);
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 14e78dd..3c62bd5 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -134,6 +134,7 @@ enum {
 	Opt_ino32,
 	Opt_noino32,
 	Opt_fscache,
+	Opt_tmpfscache,
 	Opt_nofscache,
 	Opt_poolperm,
 	Opt_nopoolperm,
@@ -170,6 +171,7 @@ static match_table_t fsopt_tokens = {
 	{Opt_ino32, "ino32"},
 	{Opt_noino32, "noino32"},
 	{Opt_fscache, "fsc"},
+	{Opt_tmpfscache, "tmpfsc"},
 	{Opt_nofscache, "nofsc"},
 	{Opt_poolperm, "poolperm"},
 	{Opt_nopoolperm, "nopoolperm"},
@@ -281,6 +283,10 @@ static int parse_fsopt_token(char *c, void *private)
 	case Opt_fscache:
 		fsopt->flags |= CEPH_MOUNT_OPT_FSCACHE;
 		break;
+	case Opt_tmpfscache:
+		fsopt->flags |= CEPH_MOUNT_OPT_FSCACHE |
+				CEPH_MOUNT_OPT_TMPFSCACHE;
+		break;
 	case Opt_nofscache:
 		fsopt->flags &= ~CEPH_MOUNT_OPT_FSCACHE;
 		break;
@@ -475,8 +481,12 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",noasyncreaddir");
 	if ((fsopt->flags & CEPH_MOUNT_OPT_DCACHE) == 0)
 		seq_puts(m, ",nodcache");
-	if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE)
-		seq_puts(m, ",fsc");
+	if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE) {
+		if (fsopt->flags & CEPH_MOUNT_OPT_TMPFSCACHE)
+			seq_puts(m, ",tmpfsc");
+		else
+			seq_puts(m, ",fsc");
+	}
 	if (fsopt->flags & CEPH_MOUNT_OPT_NOPOOLPERM)
 		seq_puts(m, ",nopoolperm");
 
@@ -597,18 +607,11 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 	if (!fsc->wb_pagevec_pool)
 		goto fail_trunc_wq;
 
-	/* setup fscache */
-	if ((fsopt->flags & CEPH_MOUNT_OPT_FSCACHE) &&
-	    (ceph_fscache_register_fs(fsc) != 0))
-		goto fail_fscache;
-
 	/* caps */
 	fsc->min_caps = fsopt->max_readdir;
 
 	return fsc;
 
-fail_fscache:
-	ceph_fscache_unregister_fs(fsc);
 fail_trunc_wq:
 	destroy_workqueue(fsc->trunc_wq);
 fail_pg_inv_wq:
@@ -626,8 +629,6 @@ static void destroy_fs_client(struct ceph_fs_client *fsc)
 {
 	dout("destroy_fs_client %p\n", fsc);
 
-	ceph_fscache_unregister_fs(fsc);
-
 	destroy_workqueue(fsc->wb_wq);
 	destroy_workqueue(fsc->pg_inv_wq);
 	destroy_workqueue(fsc->trunc_wq);
@@ -820,6 +821,14 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc)
 		if (err < 0)
 			goto out;
 
+		/* setup fscache */
+		if (fsc->mount_options->flags & CEPH_MOUNT_OPT_FSCACHE) {
+			bool tmpfsc = fsc->mount_options->flags & CEPH_MOUNT_OPT_TMPFSCACHE;
+			err = ceph_fscache_register_fs(fsc, tmpfsc);
+			if (err < 0)
+				goto out;
+		}
+
 		if (!fsc->mount_options->server_path) {
 			path = "";
 			dout("mount opening path \\t\n");
@@ -1042,6 +1051,8 @@ static void ceph_kill_sb(struct super_block *s)
 	fsc->client->extra_mon_dispatch = NULL;
 	ceph_fs_debugfs_cleanup(fsc);
 
+	ceph_fscache_unregister_fs(fsc);
+
 	ceph_mdsc_destroy(fsc);
 
 	destroy_fs_client(fsc);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index f8a0aba..4ce65d7 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -36,8 +36,9 @@
 #define CEPH_MOUNT_OPT_INO32           (1<<8) /* 32 bit inos */
 #define CEPH_MOUNT_OPT_DCACHE          (1<<9) /* use dcache for readdir etc */
 #define CEPH_MOUNT_OPT_FSCACHE         (1<<10) /* use fscache */
-#define CEPH_MOUNT_OPT_NOPOOLPERM      (1<<11) /* no pool permission check */
-#define CEPH_MOUNT_OPT_MOUNTWAIT       (1<<12) /* mount waits if no mds is up */
+#define CEPH_MOUNT_OPT_TMPFSCACHE      (1<<11) /* use fscache (data get invalidated after umount) */
+#define CEPH_MOUNT_OPT_NOPOOLPERM      (1<<12) /* no pool permission check */
+#define CEPH_MOUNT_OPT_MOUNTWAIT       (1<<13) /* mount waits if no mds is up */
 
 #define CEPH_MOUNT_OPT_DEFAULT    CEPH_MOUNT_OPT_DCACHE
 

--Apple-Mail=_86A6265E-7341-4C5E-B64E-9C626040C27D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii




how about this patch. It adds mount option to control using fsid as key =
or client as key.

Regards
Yan, Zheng


> On Thu, Jun 22, 2017 at 9:40 AM, Anish Gupta <anish_gupta@yahoo.com> =
wrote:
>> Hello Zheng,
>>=20
>>> I wrote a fix.
>>> =
https://github.com/ceph/ceph-client/commit/69faba61acd2218bb58a0202733c788=
7cbf09782
>>=20
>>=20
>> I modified my test now:
>>=20
>> loop:
>> - mount two users with FSCache
>> - copy/read the same data from each user and verify it gets cached
>> correctly
>> - unmount the two users
>>=20
>> For each iteration, I noticed fscache space usage goes up by amount
>> read/copied per user.
>> Even though I am reading the same data again and again for each =
iteration;
>> as each mount got a unique session-ID, a new subtree gets created in =
backend
>> storage of fscache.
>>=20
>> Is there was to use inode number along with FSID to reduce the amount =
of
>> space being consumed?
>> Inode number doesn't change per iteration as the same data is being
>> referenced.
>>=20
>> thanks,
>> Anish
>>=20
>>=20
>> ________________________________
>> From: "Yan, Zheng" <zyan@redhat.com>
>> To: Anish Gupta <anish_gupta@yahoo.com>
>> Cc: Milosz Tanski <milosz@adfin.com>; Sage Weil <sage@newdream.net>; =
Sage
>> Weil <sweil@redhat.com>; "yunchuanwen@ubuntukylin.com"
>> <yunchuanwen@ubuntukylin.com>
>> Sent: Wednesday, June 14, 2017 2:44 AM
>> Subject: Re: IMPORTANT: Help: CephFS: FSCache: Multiple "user" =
mounts: leads
>> to kernel crash always
>>=20
>>=20
>>> On 14 Jun 2017, at 11:54, Anish Gupta <anish_gupta@yahoo.com> wrote:
>>>=20
>>> Hello Milos,
>>>=20
>>>=20
>>> I tried a different use case with a single user:
>>> - Mounted a user's share with FSCache enabled . (for e.g. /user1 )
>>> - Mounted a sub-directory of the same user's share with FScache =
enabled (
>>> for e.g. /user1/dirA )
>>> - copied a file from /user1 -> Works (fscache stats reflect that)
>>> - copied a file from /user1/dir1 -> Leads to the kernel panic shown =
below.
>>>=20
>>> Possible explanation of panic:
>>> - When "/user1" was mounted it got a unique FSID
>>> - When "/user1/dir1" was mounted it gets the same FSID
>>> - The code that is used to ensure it is unique looks at mount opts, =
FSID
>>> compare and doesn't find a collision. See ceph_compare_super() in
>>> fs/ceph/super.c
>>>=20
>>> FWIW I think what works with FSCache is one user, one mount point =
from one
>>> Ceph Cluster.
>>> If I try to mount a different Ceph Cluster that has the same =
"namespace"
>>> and "mountpoint", I think I will run into the same kernel panic =
scenario.
>>>=20
>>> Going forward, we need your help to brainstorm a solution where for =
every
>>> mount the code can figure out a unique FSID based on some =
parameters.
>>> Kindly help as we really want to use FSCache w/ Ceph with one/multi =
user
>>> support.
>>>=20
>>>=20
>>> Sage,
>>>   Some other filesystems that use FSCache get some data from the
>>> back-end-storage Server that helps them determine a unique "FSID" =
per mount.
>>>   Can CephFS Cluster (at the Server) provide some "unique" data per
>>> mount?
>>>=20
>>=20
>> I wrote a fix.
>> =
https://github.com/ceph/ceph-client/commit/69faba61acd2218bb58a0202733c788=
7cbf09782
>>=20
>> Regards
>> Yan, Zheng
>>=20
>>> thanks,
>>> Anish
>>>=20
>>> From: Anish Gupta <anish_gupta@yahoo.com>
>>> To: Milosz Tanski <milosz@adfin.com>
>>> Cc: Sage Weil <sage@newdream.net>; Sage Weil <sweil@redhat.com>;
>>> "yunchuanwen@ubuntukylin.com" <yunchuanwen@ubuntukylin.com>;
>>> "zyan@redhat.com" <zyan@redhat.com>
>>> Sent: Tuesday, June 13, 2017 11:37 AM
>>> Subject: Re: Help: CephFS: FSCache: Multiple "user" mounts: leads to
>>> kernel crash always
>>>=20
>>> Hello Milos,
>>>=20
>>>> I never tested your use case
>>>=20
>>> AG> We were a NAS house where each user had their own share. Trying =
to do
>>> the same with Ceph that each user gets their own secret key and =
share.
>>>=20
>>>> If memory serves me correct, the objects ids in fscache (filesystem =
&
>>> files) should be the same if you mount it twice. Instinctively it
>>> makes sense since they are the same (regardless who mounted it). In
>>> this case the parent filesystem is indexed by ceph's fsid and inside
>>> that index's namespace the files are keyed on their cephfs inode id.
>>>=20
>>> AG> I do see that fsid is common across users.
>>>=20
>>>=20
>>> I simplified the test case a bit more:
>>> - mount two users with FSCache
>>> - copy a simple text file from one user's share
>>> - copy a completely different small text file from 2nd user's share =
<<<
>>> leads to crash.
>>>=20
>>> I have some additional debug messages for now and will work on =
adding
>>> line#s next:
>>>=20
>>> Flow of code is as follows:
>>>=20
>>> When 2nd user's file is being copied:
>>>=20
>>> fs/fscache/object.c
>>>=20
>>>   445 static const struct fscache_state =
*fscache_look_up_object(struct
>>> fscache_object *object,
>>>   446                                                          int =
event)
>>> ..
>>>   475        fscache_stat(&fscache_n_object_lookups);
>>>   476        fscache_stat(&fscache_n_cop_lookup_object);
>>>   477        ret =3D object->cache->ops->lookup_object(object);
>>>   478        fscache_stat_d(&fscache_n_cop_lookup_object);
>>>=20
>>> Line#477 above ends up in cachefiles.c/interface.c
>>>   117 static int cachefiles_lookup_object(struct fscache_object =
*_object)
>>>   118 {
>>> ..
>>>   135        /* look up the key, creating any missing bits */
>>>   136        cachefiles_begin_secure(cache, &saved_cred);
>>>   137        ret =3D cachefiles_walk_to_object(parent, object,
>>>   138                                        lookup_data->key,
>>>   139                                        lookup_data->auxdata);
>>>=20
>>> This ends up in cachefiles/namei.c
>>>   480 /*
>>>   481  * walk from the parent object to the child object through the
>>> backing
>>>   482  * filesystem, creating directories as we go
>>>   483  */
>>>   484 int cachefiles_walk_to_object(struct cachefiles_object =
*parent,
>>>   485                              struct cachefiles_object *object,
>>>   486                              const char *key,
>>>   487                              struct cachefiles_xattr *auxdata)
>>>   488 {
>>> ..
>>>   660        /* note that we're now using this object */
>>>   661        ret =3D cachefiles_mark_object_active(cache, object);
>>>=20
>>>=20
>>> This ends up in:
>>>   149 static int cachefiles_mark_object_active(struct =
cachefiles_cache
>>> *cache,
>>>   150                                          struct =
cachefiles_object
>>> *object)
>>>   151 {
>>> ..
>>>   195 wait_for_old_object:
>>>   196        if (fscache_object_is_live(&xobject->fscache)) {
>>>   197                pr_err("Object: %p, state: %lu\n", xobject,
>>> xobject->flags);
>>>   198                pr_err("Error: Unexpected object collision\n");
>>>   199                cachefiles_printk_object(object, xobject);
>>>   200                BUG();
>>>   201        }
>>>=20
>>>=20
>>> Blows up in line#200 above.
>>>=20
>>>=20
>>>=20
>>> [  93.419963] FS-Cache: Netfs 'ceph' registered for caching
>>> [  93.419969] ceph: loaded (mds proto 32)
>>> [  93.430668] libceph: mon1 XXXX:6789 session established
>>> [  93.433137] libceph: client2377426 fsid
>>> acc98af3-bb3c-49d0-a088-106680431ad4
>>> [  93.472641] libceph: mon1 XXXX:6789 session established
>>> [  93.474242] libceph: client2377429 fsid
>>> acc98af3-bb3c-49d0-a088-106680431ad4
>>> [  93.508985] libceph: mon2 XXX.93:6789 session established
>>>=20
>>> AG> I blanked out the 3 monitor IP addresses.
>>>=20
>>> [  93.510687] libceph: client1700621 fsid
>>> acc98af3-bb3c-49d0-a088-106680431ad4
>>> [  131.830423] [cp    ] =3D=3D> fscache_select_cache_for_object()
>>> [  131.830430] [cp    ] =3D=3D> =
fscache_fsdef_netfs_get_key({ceph.0},)
>>> [  131.830431] [cp    ] =3D=3D> =
fscache_fsdef_netfs_get_aux({ceph.0},)
>>> [  131.830475] [kworke] =3D=3D> =
fscache_fsdef_netfs_check_aux({ceph},,4)
>>> [  131.830479] CacheFiles: cachefiles_mark_object_active: Object =3D
>>> ffff887e29dec300, flags: 0
>>> [  131.830488] CacheFiles: cachefiles_mark_object_active: Object =3D
>>> ffff887e29dec180, flags: 0
>>>=20
>>> AG> "object" for first user's small text file i.e. ffff887e29dec180
>>>=20
>>>=20
>>> [  131.830654] CacheFiles: cachefiles_mark_object_active: Object =3D
>>> ffff887e29dec000, flags: 0
>>>=20
>>> [  221.211209] [cp    ] =3D=3D> fscache_select_cache_for_object()
>>> [  221.211282] CacheFiles: cachefiles_mark_object_active: Object =3D
>>> ffff887e377ac180, flags: 0
>>>=20
>>> AG> "object" for 2nd user's small text file i.e. ffff887e377ac180
>>> AG> In cachefiles_mark_object_active() of cachefiles/namei.c , both =
users
>>> end up being computed to the same "cache" variable.
>>> AG> The "cache" variable is computed in cachefiles_walk_to_object()
>>>=20
>>>=20
>>> [  221.211285] CacheFiles: Object: ffff887e29dec180, state: 1
>>> [  221.211289] CacheFiles: Error: Unexpected object collision
>>> [  221.211292] CacheFiles: object: OBJ5
>>> [  221.211295] CacheFiles: objstate=3DLOOK_UP_OBJECT fl=3D8 wbusy=3D2 =
ev=3D0[0]
>>> [  221.211298] CacheFiles: ops=3D0 inp=3D0 exc=3D0
>>> [  221.211300] CacheFiles: parent=3Dffff887e29dec300
>>> [  221.211302] CacheFiles: cookie=3Dffff887e12904000 =
[pr=3Dffff887e12398000
>>> nd=3Dffff887e396356c0 fl=3D22]
>>> [  221.211305] CacheFiles: key=3D[16] =
'acc98af3bb3c49d0a088106680431ad4'
>>> [  221.211317] CacheFiles: xobject: OBJ2
>>> [  221.211346] CacheFiles: xobjstate=3DWAIT_FOR_CMD fl=3D38 wbusy=3D0 =
ev=3D10[6d]
>>> [  221.211348] CacheFiles: xops=3D0 inp=3D0 exc=3D0
>>> [  221.211349] CacheFiles: xparent=3Dffff887e29dec300
>>> [  221.211352] CacheFiles: xcookie=3Dffff887e12398058 =
[pr=3Dffff887e12398000
>>> nd=3Dffff887e34c49f00 fl=3D20]
>>> [  221.211354] CacheFiles: xkey=3D[16] =
'acc98af3bb3c49d0a088106680431ad4'
>>> [  221.211410] ------------[ cut here ]------------
>>> [  221.211412] kernel BUG at fs/cachefiles/namei.c:199!
>>> [  221.211418] invalid opcode: 0000 [#1] SMP
>>> [  221.211437] Modules linked in: ipt_MASQUERADE =
nf_nat_masquerade_ipv4
>>> nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo iptable_nat
>>> nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype =
iptable_filter
>>> ip_tables xt_conntrack x_tables nf_nat nf_conntrack br_netfilter =
bridge stp
>>> llc ceph libceph libcrc32c overlay ipmi_msghandler cachefiles =
nouveau
>>> snd_hda_codec_hdmi intel_rapl x86_pkg_temp_thermal intel_powerclamp =
ttm
>>> drm_kms_helper coretemp snd_hda_codec_realtek snd_hda_codec_generic =
kvm
>>> snd_hda_intel snd_hda_codec drm snd_hda_core snd_hwdep nfsd snd_pcm
>>> irqbypass crct10dif_pclmul crc32_pclmul snd_seq_midi =
ghash_clmulni_intel
>>> snd_seq_midi_event pcbc snd_rawmidi eeepc_wmi auth_rpcgss snd_seq
>>> aesni_intel i2c_algo_bit bnep asus_wmi rfcomm fb_sys_fops aes_x86_64 =
nfs_acl
>>> crypto_simd syscopyarea sparse_keymap
>>> [  221.211588]  snd_seq_device glue_helper sysfillrect nfs joydev
>>> input_leds video mxm_wmi snd_timer sysimgblt cryptd snd bluetooth =
mei_me mei
>>> soundcore shpchp lockd lpc_ich wmi ecdh_generic grace sunrpc mac_hid
>>> parport_pc ppdev fscache binfmt_misc lp parport btrfs xor =
hid_generic usbhid
>>> hid raid6_pq e1000e nvme ptp ahci nvme_core libahci pps_core
>>> [  221.211677] CPU: 7 PID: 255 Comm: kworker/u24:12 Not tainted
>>> 4.12.0-rc5ceph+ #2
>>> [  221.211685] Hardware name: ASUS All Series/X99-A/USB 3.1, BIOS =
3402
>>> 08/18/2016
>>> [  221.211700] Workqueue: fscache_object fscache_object_work_func
>>> [fscache]
>>> [  221.211708] task: ffff887e127e6580 task.stack: ffffb1fc4410c000
>>> [  221.211719] RIP: 0010:cachefiles_walk_to_object+0xd3b/0xe20
>>> [cachefiles]
>>> [  221.211726] RSP: 0018:ffffb1fc4410fcf0 EFLAGS: 00010202
>>> [  221.211733] RAX: ffff887e346cd401 RBX: ffff887e377ac180 RCX:
>>> 0000000000001673
>>> [  221.211740] RDX: 0000000000001672 RSI: 0000000000000001 RDI:
>>> ffff887e3ec032c0
>>> [  221.211747] RBP: ffffb1fc4410fda0 R08: 000000000001f1a0 R09:
>>> ffffffffc052fa7b
>>> [  221.211754] R10: ffff887e3f3df1a0 R11: ffffed3d1fd1b300 R12:
>>> ffff887e29dec180
>>> [  221.211760] R13: ffff887e29dec428 R14: ffff887e29dec2a8 R15:
>>> ffff887e1166c840
>>> [  221.211768] FS:  0000000000000000(0000) GS:ffff887e3f3c0000(0000)
>>> knlGS:0000000000000000
>>> [  221.211775] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  221.211782] CR2: 00007fcfc97b54e0 CR3: 00000004bbe09000 CR4:
>>> 00000000001406e0
>>> [  221.211789] Call Trace:
>>> [  221.211801]  ? __queue_work+0x142/0x3c0
>>> [  221.211810]  cachefiles_lookup_object+0x5e/0x160 [cachefiles]
>>> [  221.211822]  fscache_look_up_object+0xe9/0x330 [fscache]
>>> [  221.211832]  fscache_object_work_func+0x100/0x450 [fscache]
>>> [  221.211840]  process_one_work+0x138/0x350
>>> [  221.211847]  worker_thread+0x4d/0x3b0
>>> [  221.211856]  kthread+0x109/0x140
>>> [  221.211862]  ? rescuer_thread+0x320/0x320
>>> [  221.211869]  ? kthread_park+0x60/0x60
>>> [  221.211879]  ret_from_fork+0x25/0x30
>>> [  221.211885] Code: e8 48 89 c3 48 c7 c7 00 27 53 c0 31 c0 e8 a7 cc =
c6 d7
>>> 48 c7 c7 28 27 53 c0 31 c0 e8 99 cc c6 d7 4c 89 e6 48 89 df e8 8d 3e =
00 00
>>> <0f> 0b 65 48 8b 34 25 40 d4 00 00 44 89 f2 48 81 c6 30 06 00 00
>>> [  221.211941] RIP: cachefiles_walk_to_object+0xd3b/0xe20 =
[cachefiles]
>>> RSP: ffffb1fc4410fcf0
>>> [  221.217118] ---[ end trace e2ed4eeaea04fee9 ]---
>>>=20
>>>=20
>>> thank you,
>>> Anish
>>>=20
>>>=20
>>> From: Milosz Tanski <milosz@adfin.com>
>>> To: Anish Gupta <anish_gupta@yahoo.com>
>>> Cc: Sage Weil <sage@newdream.net>; Sage Weil <sweil@redhat.com>;
>>> "yunchuanwen@ubuntukylin.com" <yunchuanwen@ubuntukylin.com>;
>>> "zyan@redhat.com" <zyan@redhat.com>
>>> Sent: Tuesday, June 13, 2017 11:00 AM
>>> Subject: Re: Help: CephFS: FSCache: Multiple "user" mounts: leads to
>>> kernel crash always
>>>=20
>>> On Tue, Jun 13, 2017 at 8:21 AM, Anish Gupta <anish_gupta@yahoo.com>
>>> wrote:
>>>> Good morning,
>>>>=20
>>>> I am testing out a Jewel LTS (v10.2.7) CephFS based storage cluster
>>>> deployment with latest kernels 4.10+.
>>>>=20
>>>> Have created multiple "users" with unique mount points and secret =
keys.
>>>> Lets
>>>> assume 2 users for this email.
>>>>=20
>>>> I mount the users using kernel client and am using fscache for perf
>>>> reasons.
>>>>=20
>>>> My test is simple:
>>>> - mount the two users
>>>> - read data from first user's mount
>>>> - read data from 2nd user's mount  <<< always leads to kernel crash
>>>>=20
>>>> Back trace looks like this:
>>>>=20
>>>> [  239.300067] invalid opcode: 0000 [#1] SMP
>>>=20
>>>=20
>>> Is there any log message before "invalid opcode: 0000 [#1] SMP"?
>>>=20
>>>> [  239.300082] Modules linked in: ceph libceph ipt_MASQUERADE
>>>> nf_nat_masquerade_ipv4 nf_conntrack_netlink nfnetlink xfrm_user
>>>> xfrm_algo
>>>> iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 =
xt_addrtype
>>>> iptable_filter ip_tables xt_conntrack x_tables nf_nat nf_conntrack
>>>> libcrc32c
>>>> br_netfilter bridge stp llc overlay ipmi_msghandler cachefiles =
nouveau
>>>> snd_hda_codec_hdmi nfsd auth_rpcgss intel_rapl nfs_acl bnep rfcomm =
nfs
>>>> snd_hda_codec_realtek snd_hda_codec_generic bluetooth
>>>> x86_pkg_temp_thermal
>>>> snd_hda_intel intel_powerclamp snd_hda_codec ttm snd_hda_core =
coretemp
>>>> snd_hwdep drm_kms_helper lockd ecdh_generic drm kvm snd_pcm grace
>>>> snd_seq_midi snd_seq_midi_event sunrpc irqbypass snd_rawmidi =
snd_seq
>>>> i2c_algo_bit crct10dif_pclmul fb_sys_fops syscopyarea crc32_pclmul
>>>> sysfillrect ghash_clmulni_intel sysimgblt
>>>> [  239.300175]  pcbc snd_seq_device snd_timer eeepc_wmi asus_wmi
>>>> aesni_intel
>>>> snd sparse_keymap aes_x86_64 video crypto_simd mei_me glue_helper
>>>> mxm_wmi
>>>> joydev fscache input_leds mei cryptd binfmt_misc shpchp soundcore
>>>> lpc_ich
>>>> wmi mac_hid parport_pc ppdev lp parport btrfs xor hid_generic =
usbhid hid
>>>> raid6_pq e1000e ptp nvme ahci pps_core nvme_core libahci
>>>> [  239.300229] CPU: 1 PID: 251 Comm: kworker/u24:8 Not tainted
>>>> 4.12.0-rc5ceph #1
>>>> [  239.300236] Hardware name: ASUS All Series/X99-A/USB 3.1, BIOS =
3402
>>>> 08/18/2016
>>>> [  239.300252] Workqueue: fscache_object fscache_object_work_func
>>>> [fscache]
>>>> [  239.300260] task: ffff964251e7d700 task.stack: ffffa1e3440c4000
>>>> [  239.300271] RIP: 0010:cachefiles_walk_to_object+0xd13/0xe00
>>>> [cachefiles]
>>>> [  239.300278] RSP: 0018:ffffa1e3440c7cf0 EFLAGS: 00010202
>>>> [  239.300285] RAX: ffff964252829401 RBX: ffff964276ce42a8 RCX:
>>>> 00000000000016a8
>>>> [  239.300292] RDX: 00000000000016a7 RSI: 0000000000000096 RDI:
>>>> ffff96427ec032c0
>>>> [  239.300298] RBP: ffffa1e3440c7da0 R08: 000000000001f1a0 R09:
>>>> ffffffffc0682a5b
>>>> [  239.300305] R10: ffff96427f25f1a0 R11: ffffdc765f4a0a00 R12:
>>>> ffff964276ce4180
>>>> [  239.300311] R13: ffff964276ce4428 R14: ffff9641dbfc4180 R15:
>>>> ffff96427e866b40
>>>> [  239.300319] FS:  0000000000000000(0000) =
GS:ffff96427f240000(0000)
>>>> knlGS:0000000000000000
>>>> [  239.300327] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [  239.300334] CR2: 0000000000f36000 CR3: 00000007f9cb5000 CR4:
>>>> 00000000001406e0
>>>> [  239.300340] Call Trace:
>>>> [  239.300353]  ? __queue_work+0x142/0x3c0
>>>> [  239.300363]  cachefiles_lookup_object+0x5e/0x160 [cachefiles]
>>>> [  239.300375]  fscache_look_up_object+0xe9/0x330 [fscache]
>>>> [  239.300385]  fscache_object_work_func+0x100/0x450 [fscache]
>>>> [  239.300393]  process_one_work+0x138/0x350
>>>> [  239.300400]  worker_thread+0x4d/0x3b0
>>>> [  239.300409]  kthread+0x109/0x140
>>>> [  239.300415]  ? rescuer_thread+0x320/0x320
>>>> [  239.300422]  ? kthread_park+0x60/0x60
>>>> [  239.300431]  ret_from_fork+0x25/0x30
>>>>=20
>>>>=20
>>>> I can provide kernel crash dump if needed. But above test steps =
seem to
>>>> reproduce this always
>>>> as soon as I access any "object" from 2nd user's share.
>>>>=20
>>>> =46rom reading the code, this seems to indicate that the "key" used =
for
>>>> 2nd
>>>> user's mount isn't unique?
>>>>=20
>>>> Any help regards this would be greatly appreciated.
>>>>=20
>>>=20
>>> I never tested your use case ... but clearly it shouldn't crash. =
It's
>>> been a while since I look at this code as it's been running for us =
on
>>> multiple systems without problems.
>>>=20
>>> If memory serves me correct, the objects ids in fscache (filesystem =
&
>>> files) should be the same if you mount it twice. Instinctively it
>>> makes sense since they are the same (regardless who mounted it). In
>>> this case the parent filesystem is indexed by ceph's fsid and inside
>>> that index's namespace the files are keyed on their cephfs inode id.
>>>=20
>>> Can you provide more information from the logs above the opcode? And
>>> if you can line numbers of the last few call stack (using addr2line)
>>> that would be appreciated.
>>>=20
>>> --
>>> Milosz Tanski
>>> CTO
>>> 16 East 34th Street, 15th floor
>>> New York, NY 10016
>>>=20
>>> p: 646-253-9055
>>>=20
>>> e:
>>> milosz@adfin.com
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>=20
>>=20
>=20
>=20
>=20
> --=20
> Milosz Tanski
> CTO
> 16 East 34th Street, 15th floor
> New York, NY 10016
>=20
> p: 646-253-9055
> e: milosz@adfin.com


--Apple-Mail=_86A6265E-7341-4C5E-B64E-9C626040C27D--
