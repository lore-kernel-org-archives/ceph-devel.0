From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Force an OSD to try to peer
Date: Tue, 31 Mar 2015 11:23:17 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503311122150.23387@cobra.newdream.net>
References: <CAANLjFowYybKKueFeHHT4Ug2eTW_-RGVQRtRE7vfgF-1XXJwkA@mail.gmail.com>
	<CAANLjFp8Vwu1=pVJy7LodbbeirRpdXPAMbOUmszkX8KuRZR4kw@mail.gmail.com>
	<alpine.DEB.2.00.1503311035540.23387@cobra.newdream.net>
	<CAANLjFp0pStF0iBw21XSv8a03YX4iy74rZSr_MD8e1mGR0KCAQ@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F28CB737E@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CB737E-cXZ6iGhjG0il5HHZYNR2WTJ2aSJ780jGSxCzGc5ayCJWk0Htik3J/w@public.gmane.org>
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
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, 31 Mar 2015, Somnath Roy wrote:
> But, do we know why Jumbo frames may have an impact on peering ?
> In our setup so far, we haven't enabled jumbo frames other than performance reason (if at all).

It's nothing specific to peering (or ceph).  The symptom we've seen is 
just that byte stop passing across a TCP connection, usually when there is 
some largish messages being sent.  The ping/heartbeat messages get through 
because they are small and we disable nagle so they never end up in large 
frames.

It's a pain to diagnose.

sage


> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of Robert LeBlanc
> Sent: Tuesday, March 31, 2015 11:08 AM
> To: Sage Weil
> Cc: ceph-devel; Ceph-User
> Subject: Re: [ceph-users] Force an OSD to try to peer
> 
> I was desperate for anything after exhausting every other possibility I could think of. Maybe I should put a checklist in the Ceph docs of things to look for.
> 
> Thanks,
> 
> On Tue, Mar 31, 2015 at 11:36 AM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > On Tue, 31 Mar 2015, Robert LeBlanc wrote:
> >> Turns out jumbo frames was not set on all the switch ports. Once that
> >> was resolved the cluster quickly became healthy.
> >
> > I always hesitate to point the finger at the jumbo frames
> > configuration but almost every time that is the culprit!
> >
> > Thanks for the update.  :)
> > sage
> >
> >
> >
> >>
> >> On Mon, Mar 30, 2015 at 8:15 PM, Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org> wrote:
> >> > I've been working at this peering problem all day. I've done a lot
> >> > of testing at the network layer and I just don't believe that we
> >> > have a problem that would prevent OSDs from peering. When looking
> >> > though osd_debug 20/20 logs, it just doesn't look like the OSDs are
> >> > trying to peer. I don't know if it is because there are so many
> >> > outstanding creations or what. OSDs will peer with OSDs on other
> >> > hosts, but for reason only chooses a certain number and not one that it needs to finish the peering process.
> >> >
> >> > I've check: firewall, open files, number of threads allowed. These
> >> > usually have given me an error in the logs that helped me fix the problem.
> >> >
> >> > I can't find a configuration item that specifies how many peers an
> >> > OSD should contact or anything that would be artificially limiting
> >> > the peering connections. I've restarted the OSDs a number of times,
> >> > as well as rebooting the hosts. I beleive if the OSDs finish
> >> > peering everything will clear up. I can't find anything in pg query
> >> > that would help me figure out what is blocking it (peering blocked
> >> > by is empty). The PGs are scattered across all the hosts so we can't pin it down to a specific host.
> >> >
> >> > Any ideas on what to try would be appreciated.
> >> >
> >> > [ulhglive-root@ceph9 ~]# ceph --version ceph version 0.80.7
> >> > (6c0127fcb58008793d3c8b62d925bc91963672a3)
> >> > [ulhglive-root@ceph9 ~]# ceph status
> >> >     cluster 48de182b-5488-42bb-a6d2-62e8e47b435c
> >> >      health HEALTH_WARN 1 pgs down; 1321 pgs peering; 1321 pgs
> >> > stuck inactive; 1321 pgs stuck unclean; too few pgs per osd (17 < min 20)
> >> >      monmap e2: 3 mons at
> >> > {mon1=10.217.72.27:6789/0,mon2=10.217.72.28:6789/0,mon3=10.217.72.2
> >> > 9:6789/0}, election epoch 30, quorum 0,1,2 mon1,mon2,mon3
> >> >      osdmap e704: 120 osds: 120 up, 120 in
> >> >       pgmap v1895: 2048 pgs, 1 pools, 0 bytes data, 0 objects
> >> >             11447 MB used, 436 TB / 436 TB avail
> >> >                  727 active+clean
> >> >                  990 peering
> >> >                   37 creating+peering
> >> >                    1 down+peering
> >> >                  290 remapped+peering
> >> >                    3 creating+remapped+peering
> >> >
> >> > { "state": "peering",
> >> >   "epoch": 707,
> >> >   "up": [
> >> >         40,
> >> >         92,
> >> >         48,
> >> >         91],
> >> >   "acting": [
> >> >         40,
> >> >         92,
> >> >         48,
> >> >         91],
> >> >   "info": { "pgid": "7.171",
> >> >       "last_update": "0'0",
> >> >       "last_complete": "0'0",
> >> >       "log_tail": "0'0",
> >> >       "last_user_version": 0,
> >> >       "last_backfill": "MAX",
> >> >       "purged_snaps": "[]",
> >> >       "history": { "epoch_created": 293,
> >> >           "last_epoch_started": 343,
> >> >           "last_epoch_clean": 343,
> >> >           "last_epoch_split": 0,
> >> >           "same_up_since": 688,
> >> >           "same_interval_since": 688,
> >> >           "same_primary_since": 608,
> >> >           "last_scrub": "0'0",
> >> >           "last_scrub_stamp": "2015-03-30 11:11:18.872851",
> >> >           "last_deep_scrub": "0'0",
> >> >           "last_deep_scrub_stamp": "2015-03-30 11:11:18.872851",
> >> >           "last_clean_scrub_stamp": "0.000000"},
> >> >       "stats": { "version": "0'0",
> >> >           "reported_seq": "326",
> >> >           "reported_epoch": "707",
> >> >           "state": "peering",
> >> >           "last_fresh": "2015-03-30 20:10:39.509855",
> >> >           "last_change": "2015-03-30 19:44:17.361601",
> >> >           "last_active": "2015-03-30 11:37:56.956417",
> >> >           "last_clean": "2015-03-30 11:37:56.956417",
> >> >           "last_became_active": "0.000000",
> >> >           "last_unstale": "2015-03-30 20:10:39.509855",
> >> >           "mapping_epoch": 683,
> >> >           "log_start": "0'0",
> >> >           "ondisk_log_start": "0'0",
> >> >           "created": 293,
> >> >           "last_epoch_clean": 343,
> >> >           "parent": "0.0",
> >> >           "parent_split_bits": 0,
> >> >           "last_scrub": "0'0",
> >> >           "last_scrub_stamp": "2015-03-30 11:11:18.872851",
> >> >           "last_deep_scrub": "0'0",
> >> >           "last_deep_scrub_stamp": "2015-03-30 11:11:18.872851",
> >> >           "last_clean_scrub_stamp": "0.000000",
> >> >           "log_size": 0,
> >> >           "ondisk_log_size": 0,
> >> >           "stats_invalid": "0",
> >> >           "stat_sum": { "num_bytes": 0,
> >> >               "num_objects": 0,
> >> >               "num_object_clones": 0,
> >> >               "num_object_copies": 0,
> >> >               "num_objects_missing_on_primary": 0,
> >> >               "num_objects_degraded": 0,
> >> >               "num_objects_unfound": 0,
> >> >               "num_objects_dirty": 0,
> >> >               "num_whiteouts": 0,
> >> >               "num_read": 0,
> >> >               "num_read_kb": 0,
> >> >               "num_write": 0,
> >> >               "num_write_kb": 0,
> >> >               "num_scrub_errors": 0,
> >> >               "num_shallow_scrub_errors": 0,
> >> >               "num_deep_scrub_errors": 0,
> >> >               "num_objects_recovered": 0,
> >> >               "num_bytes_recovered": 0,
> >> >               "num_keys_recovered": 0,
> >> >               "num_objects_omap": 0,
> >> >               "num_objects_hit_set_archive": 0},
> >> >           "stat_cat_sum": {},
> >> >           "up": [
> >> >                 40,
> >> >                 92,
> >> >                 48,
> >> >                 91],
> >> >           "acting": [
> >> >                 40,
> >> >                 92,
> >> >                 48,
> >> >                 91],
> >> >           "up_primary": 40,
> >> >           "acting_primary": 40},
> >> >       "empty": 1,
> >> >       "dne": 0,
> >> >       "incomplete": 0,
> >> >       "last_epoch_started": 348,
> >> >       "hit_set_history": { "current_last_update": "0'0",
> >> >           "current_last_stamp": "0.000000",
> >> >           "current_info": { "begin": "0.000000",
> >> >               "end": "0.000000",
> >> >               "version": "0'0"},
> >> >           "history": []}},
> >> >   "peer_info": [
> >> >         { "peer": "48",
> >> >           "pgid": "7.171",
> >> >           "last_update": "0'0",
> >> >           "last_complete": "0'0",
> >> >           "log_tail": "0'0",
> >> >           "last_user_version": 0,
> >> >           "last_backfill": "MAX",
> >> >           "purged_snaps": "[]",
> >> >           "history": { "epoch_created": 293,
> >> >               "last_epoch_started": 343,
> >> >               "last_epoch_clean": 343,
> >> >               "last_epoch_split": 0,
> >> >               "same_up_since": 688,
> >> >               "same_interval_since": 688,
> >> >               "same_primary_since": 608,
> >> >               "last_scrub": "0'0",
> >> >               "last_scrub_stamp": "2015-03-30 11:11:18.872851",
> >> >               "last_deep_scrub": "0'0",
> >> >               "last_deep_scrub_stamp": "2015-03-30 11:11:18.872851",
> >> >               "last_clean_scrub_stamp": "0.000000"},
> >> >           "stats": { "version": "0'0",
> >> >               "reported_seq": "24",
> >> >               "reported_epoch": "348",
> >> >               "state": "peering",
> >> >               "last_fresh": "2015-03-30 11:39:02.979742",
> >> >               "last_change": "2015-03-30 11:39:01.650897",
> >> >               "last_active": "2015-03-30 11:37:56.956417",
> >> >               "last_clean": "2015-03-30 11:37:56.956417",
> >> >               "last_became_active": "0.000000",
> >> >               "last_unstale": "2015-03-30 11:39:02.979742",
> >> >               "mapping_epoch": 683,
> >> >               "log_start": "0'0",
> >> >               "ondisk_log_start": "0'0",
> >> >               "created": 293,
> >> >               "last_epoch_clean": 343,
> >> >               "parent": "0.0",
> >> >               "parent_split_bits": 0,
> >> >               "last_scrub": "0'0",
> >> >               "last_scrub_stamp": "2015-03-30 11:11:18.872851",
> >> >               "last_deep_scrub": "0'0",
> >> >               "last_deep_scrub_stamp": "2015-03-30 11:11:18.872851",
> >> >               "last_clean_scrub_stamp": "0.000000",
> >> >               "log_size": 0,
> >> >               "ondisk_log_size": 0,
> >> >               "stats_invalid": "0",
> >> >               "stat_sum": { "num_bytes": 0,
> >> >                   "num_objects": 0,
> >> >                   "num_object_clones": 0,
> >> >                   "num_object_copies": 0,
> >> >                   "num_objects_missing_on_primary": 0,
> >> >                   "num_objects_degraded": 0,
> >> >                   "num_objects_unfound": 0,
> >> >                   "num_objects_dirty": 0,
> >> >                   "num_whiteouts": 0,
> >> >                   "num_read": 0,
> >> >                   "num_read_kb": 0,
> >> >                   "num_write": 0,
> >> >                   "num_write_kb": 0,
> >> >                   "num_scrub_errors": 0,
> >> >                   "num_shallow_scrub_errors": 0,
> >> >                   "num_deep_scrub_errors": 0,
> >> >                   "num_objects_recovered": 0,
> >> >                   "num_bytes_recovered": 0,
> >> >                   "num_keys_recovered": 0,
> >> >                   "num_objects_omap": 0,
> >> >                   "num_objects_hit_set_archive": 0},
> >> >               "stat_cat_sum": {},
> >> >               "up": [
> >> >                     40,
> >> >                     92,
> >> >                     48,
> >> >                     91],
> >> >               "acting": [
> >> >                     40,
> >> >                     92,
> >> >                     48,
> >> >                     91],
> >> >               "up_primary": 40,
> >> >               "acting_primary": 40},
> >> >           "empty": 1,
> >> >           "dne": 0,
> >> >           "incomplete": 0,
> >> >           "last_epoch_started": 348,
> >> >           "hit_set_history": { "current_last_update": "0'0",
> >> >               "current_last_stamp": "0.000000",
> >> >               "current_info": { "begin": "0.000000",
> >> >                   "end": "0.000000",
> >> >                   "version": "0'0"},
> >> >               "history": []}},
> >> >         { "peer": "110",
> >> >           "pgid": "7.171",
> >> >           "last_update": "0'0",
> >> >           "last_complete": "0'0",
> >> >           "log_tail": "0'0",
> >> >           "last_user_version": 0,
> >> >           "last_backfill": "MAX",
> >> >           "purged_snaps": "[]",
> >> >           "history": { "epoch_created": 0,
> >> >               "last_epoch_started": 0,
> >> >               "last_epoch_clean": 0,
> >> >               "last_epoch_split": 0,
> >> >               "same_up_since": 0,
> >> >               "same_interval_since": 0,
> >> >               "same_primary_since": 0,
> >> >               "last_scrub": "0'0",
> >> >               "last_scrub_stamp": "0.000000",
> >> >               "last_deep_scrub": "0'0",
> >> >               "last_deep_scrub_stamp": "0.000000",
> >> >               "last_clean_scrub_stamp": "0.000000"},
> >> >           "stats": { "version": "0'0",
> >> >               "reported_seq": "0",
> >> >               "reported_epoch": "0",
> >> >               "state": "inactive",
> >> >               "last_fresh": "0.000000",
> >> >               "last_change": "0.000000",
> >> >               "last_active": "0.000000",
> >> >               "last_clean": "0.000000",
> >> >               "last_became_active": "0.000000",
> >> >               "last_unstale": "0.000000",
> >> >               "mapping_epoch": 0,
> >> >               "log_start": "0'0",
> >> >               "ondisk_log_start": "0'0",
> >> >               "created": 0,
> >> >               "last_epoch_clean": 0,
> >> >               "parent": "0.0",
> >> >               "parent_split_bits": 0,
> >> >               "last_scrub": "0'0",
> >> >               "last_scrub_stamp": "0.000000",
> >> >               "last_deep_scrub": "0'0",
> >> >               "last_deep_scrub_stamp": "0.000000",
> >> >               "last_clean_scrub_stamp": "0.000000",
> >> >               "log_size": 0,
> >> >               "ondisk_log_size": 0,
> >> >               "stats_invalid": "0",
> >> >               "stat_sum": { "num_bytes": 0,
> >> >                   "num_objects": 0,
> >> >                   "num_object_clones": 0,
> >> >                   "num_object_copies": 0,
> >> >                   "num_objects_missing_on_primary": 0,
> >> >                   "num_objects_degraded": 0,
> >> >                   "num_objects_unfound": 0,
> >> >                   "num_objects_dirty": 0,
> >> >                   "num_whiteouts": 0,
> >> >                   "num_read": 0,
> >> >                   "num_read_kb": 0,
> >> >                   "num_write": 0,
> >> >                   "num_write_kb": 0,
> >> >                   "num_scrub_errors": 0,
> >> >                   "num_shallow_scrub_errors": 0,
> >> >                   "num_deep_scrub_errors": 0,
> >> >                   "num_objects_recovered": 0,
> >> >                   "num_bytes_recovered": 0,
> >> >                   "num_keys_recovered": 0,
> >> >                   "num_objects_omap": 0,
> >> >                   "num_objects_hit_set_archive": 0},
> >> >               "stat_cat_sum": {},
> >> >               "up": [],
> >> >               "acting": [],
> >> >               "up_primary": -1,
> >> >               "acting_primary": -1},
> >> >           "empty": 1,
> >> >           "dne": 1,
> >> >           "incomplete": 0,
> >> >           "last_epoch_started": 0,
> >> >           "hit_set_history": { "current_last_update": "0'0",
> >> >               "current_last_stamp": "0.000000",
> >> >               "current_info": { "begin": "0.000000",
> >> >                   "end": "0.000000",
> >> >                   "version": "0'0"},
> >> >               "history": []}}],
> >> >   "recovery_state": [
> >> >         { "name": "Started\/Primary\/Peering\/GetInfo",
> >> >           "enter_time": "2015-03-30 19:44:18.709317",
> >> >           "requested_info_from": [
> >> >                 { "osd": "0"},
> >> >                 { "osd": "5"},
> >> >                 { "osd": "10"},
> >> >                 { "osd": "22"},
> >> >                 { "osd": "54"},
> >> >                 { "osd": "91"},
> >> >                 { "osd": "92"},
> >> >                 { "osd": "113"},
> >> >                 { "osd": "114"}]},
> >> >         { "name": "Started\/Primary\/Peering",
> >> >           "enter_time": "2015-03-30 19:44:18.709316",
> >> >           "past_intervals": [
> >> >                 { "first": 342,
> >> >                   "last": 346,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         114],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         114,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 347,
> >> >                   "last": 353,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         48],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 354,
> >> >                   "last": 356,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         92,
> >> >                         48],
> >> >                   "acting": [
> >> >                         92,
> >> >                         48,
> >> >                         92,
> >> >                         92]},
> >> >                 { "first": 357,
> >> >                   "last": 359,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         113,
> >> >                         48,
> >> >                         114],
> >> >                   "acting": [
> >> >                         113,
> >> >                         48,
> >> >                         114,
> >> >                         113,
> >> >                         113]},
> >> >                 { "first": 360,
> >> >                   "last": 361,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         48],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 362,
> >> >                   "last": 364,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 365,
> >> >                   "last": 369,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         114],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         114,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 370,
> >> >                   "last": 379,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         48],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 380,
> >> >                   "last": 400,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         91],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         91,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 401,
> >> >                   "last": 409,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         92,
> >> >                         48,
> >> >                         91],
> >> >                   "acting": [
> >> >                         92,
> >> >                         48,
> >> >                         91,
> >> >                         92,
> >> >                         92]},
> >> >                 { "first": 410,
> >> >                   "last": 414,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         113,
> >> >                         48,
> >> >                         114,
> >> >                         0],
> >> >                   "acting": [
> >> >                         113,
> >> >                         48,
> >> >                         114,
> >> >                         0,
> >> >                         113,
> >> >                         113]},
> >> >                 { "first": 415,
> >> >                   "last": 435,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         113,
> >> >                         48,
> >> >                         114,
> >> >                         10],
> >> >                   "acting": [
> >> >                         113,
> >> >                         48,
> >> >                         114,
> >> >                         10,
> >> >                         113,
> >> >                         113]},
> >> >                 { "first": 436,
> >> >                   "last": 442,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         91],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         91,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 443,
> >> >                   "last": 446,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         48],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 447,
> >> >                   "last": 457,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         48],
> >> >                   "acting": [
> >> >                         40,
> >> >                         48,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 458,
> >> >                   "last": 460,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         48,
> >> >                         10],
> >> >                   "acting": [
> >> >                         40,
> >> >                         48,
> >> >                         10,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 461,
> >> >                   "last": 466,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         48,
> >> >                         22],
> >> >                   "acting": [
> >> >                         40,
> >> >                         48,
> >> >                         22,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 467,
> >> >                   "last": 478,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         48,
> >> >                         22,
> >> >                         5],
> >> >                   "acting": [
> >> >                         40,
> >> >                         48,
> >> >                         22,
> >> >                         5,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 479,
> >> >                   "last": 489,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         48,
> >> >                         22,
> >> >                         110],
> >> >                   "acting": [
> >> >                         40,
> >> >                         48,
> >> >                         22,
> >> >                         110,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 490,
> >> >                   "last": 496,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         48,
> >> >                         22,
> >> >                         0],
> >> >                   "acting": [
> >> >                         40,
> >> >                         48,
> >> >                         22,
> >> >                         0,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 497,
> >> >                   "last": 507,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         48,
> >> >                         114,
> >> >                         10],
> >> >                   "acting": [
> >> >                         40,
> >> >                         48,
> >> >                         114,
> >> >                         10,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 508,
> >> >                   "last": 511,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         48,
> >> >                         54,
> >> >                         91],
> >> >                   "acting": [
> >> >                         40,
> >> >                         48,
> >> >                         54,
> >> >                         91,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 512,
> >> >                   "last": 579,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         91],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         91,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 580,
> >> >                   "last": 580,
> >> >                   "maybe_went_rw": 0,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         91],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         91,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 581,
> >> >                   "last": 591,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         92,
> >> >                         91],
> >> >                   "acting": [
> >> >                         92,
> >> >                         91,
> >> >                         92,
> >> >                         92]},
> >> >                 { "first": 592,
> >> >                   "last": 595,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         113,
> >> >                         114,
> >> >                         22,
> >> >                         0],
> >> >                   "acting": [
> >> >                         113,
> >> >                         114,
> >> >                         22,
> >> >                         0,
> >> >                         113,
> >> >                         113]},
> >> >                 { "first": 596,
> >> >                   "last": 599,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         113,
> >> >                         48,
> >> >                         114,
> >> >                         10],
> >> >                   "acting": [
> >> >                         113,
> >> >                         48,
> >> >                         114,
> >> >                         10,
> >> >                         113,
> >> >                         113]},
> >> >                 { "first": 600,
> >> >                   "last": 606,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         91],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         91,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 607,
> >> >                   "last": 607,
> >> >                   "maybe_went_rw": 0,
> >> >                   "up": [
> >> >                         92,
> >> >                         91],
> >> >                   "acting": [
> >> >                         92,
> >> >                         91,
> >> >                         92,
> >> >                         92]},
> >> >                 { "first": 608,
> >> >                   "last": 616,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         91],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         91,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 617,
> >> >                   "last": 625,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         91],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         91,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 626,
> >> >                   "last": 632,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         114,
> >> >                         10],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         114,
> >> >                         10,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 633,
> >> >                   "last": 639,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         91],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         91,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 640,
> >> >                   "last": 643,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         91],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         91,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 644,
> >> >                   "last": 662,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         114,
> >> >                         10],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         114,
> >> >                         10,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 663,
> >> >                   "last": 679,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         91],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         91,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 680,
> >> >                   "last": 682,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         48],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         40,
> >> >                         40]},
> >> >                 { "first": 683,
> >> >                   "last": 687,
> >> >                   "maybe_went_rw": 1,
> >> >                   "up": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         10],
> >> >                   "acting": [
> >> >                         40,
> >> >                         92,
> >> >                         48,
> >> >                         10,
> >> >                         40,
> >> >                         40]}],
> >> >           "probing_osds": [
> >> >                 "0",
> >> >                 "5",
> >> >                 "10",
> >> >                 "22",
> >> >                 "40",
> >> >                 "48",
> >> >                 "54",
> >> >                 "91",
> >> >                 "92",
> >> >                 "110",
> >> >                 "113",
> >> >                 "114"],
> >> >           "down_osds_we_would_probe": [],
> >> >           "peering_blocked_by": []},
> >> >         { "name": "Started",
> >> >           "enter_time": "2015-03-30 19:44:18.709312"}],
> >> >   "agent_state": {}}
> >> >
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> >> in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo
> >> info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> ________________________________
> 
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> 
> 
