From: Alex Elder <elder@inktank.com>
Subject: Re: rbd map command hangs for 15 minutes during system start up
Date: Mon, 10 Dec 2012 15:57:57 -0600
Message-ID: <50C65AE5.2050704@inktank.com>
References: <CA+jddaMAx8OKd8-uHaj-eDx8PJwZB=ew7PkkSAy8Y3Uwm5S85g@mail.gmail.com> <CAPud5_7GXtKn4G4GW+DWA7iFZHub8=hMWxnYfko=u9x+bKgQ6A@mail.gmail.com> <CAPYLRzj=i-cvOQJdUTbGtkjjAr6H4ohwbGe3Qnm1nYPwAjjLJA@mail.gmail.com> <CAPud5_6vGTpPVDATu6U_X5urkXpM5vhDXg3E5MbPu-07MTGuxQ@mail.gmail.com> <CAPud5_4hSU9j5+6EL2VWDuZW0xfFNLCo-_KvDcWDkm9H2pd21w@mail.gmail.com> <alpine.DEB.2.00.1211210849060.1082@cobra.newdream.net> <CAPud5_6fCfOkXviFB6rz9YvWYBkwNzf699Z1_TW3_v4nCoaUQA@mail.gmail.com> <CAPud5_7jXmz9Bz9hAcQKG769wvuCn2eWkV-wc_qEZ7kPdsZf1Q@mail.gmail.com> <CAPud5_7P_Z-+14kyGZGxLCUY4SfTWnW3kTOpMh3OYBWgWCt_1w@mail.gmail.com> <alpine.DEB.2.00.1211212041240.9963@cobra.newdream.net> <CAPud5_4S6-K33f4qLR+-cMm5NLn35H3aXo_LVSenwBM2sxgELg@mail.gmail.com> <CAPud5_7EckkvSth8+YeGvEph1GxjTqovXhG6gVWKUX-3K9cLjQ@ma
 il.gmail.com> <50B7C788.6040404@inktank.com> <50B93FCA.2060801@inktank.com> <CAPud5_4avt1ohkdg3s_pcwoF+4AfuAYDP3qJUqL84nFnmh2GjA@mail.gmail.com> <50BC2DE6.6050307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60529 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab2LJV6D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 16:58:03 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so2801125obb.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 13:58:01 -0800 (PST)
In-Reply-To: <50BC2DE6.6050307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: Sage Weil <sage@inktank.com>, Gregory Farnum <greg@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, Mandell Degerness <mandell@pistoncloud.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/02/2012 10:43 PM, Alex Elder wrote:
> On 12/01/2012 11:34 PM, Nick Bartos wrote:
>> Unfortunately the hangs happen with the new set of patches.  Here's
>> some debug info:
>>
>> https://gist.github.com/raw/4187123/90194ce172130244a9c1c968ed185eee7282d809/gistfile1.txt
>>
> 
> Well I'm sorry to hear that but I'm glad to have the new info.
> 
> In retrospect running the new patches *without* the one that
> seems to cause the hang (#50) were good validation that they
> didn't lead to any new problems.
> 
> I'll look at this some more in the morning, and I think I'll
> confer with Sage whenever he's available for ideas on how to
> proceed.

Over the course of last week I have been finding and fixing a
few problems in rbd, the osd client, and the messenger in the
Linux kernel code.  I've added a handful of new patches to the
end of the ones I gave you last time.

At this point I don't expect these changes directly affect
the hangs you have been seeing, but a couple of these are
real problems you could (also) hit, and I'd like to avoid
that.

I haven't done rigorous testing on this but I believe
the changes are correct (and Sage has looked at them
and says they look OK to him).

The new version is available in the branch "wip-nick-new"
in the ceph-client git repository.  If you reproduce your
hang with this updated code (or do not), please let me know.

Thanks.

					-Alex


>                     -Alex
> 
> 
>> On Fri, Nov 30, 2012 at 3:22 PM, Alex Elder <elder@inktank.com> wrote:
>>> On 11/29/2012 02:37 PM, Alex Elder wrote:
>>>> On 11/22/2012 12:04 PM, Nick Bartos wrote:
>>>>> Here are the ceph log messages (including the libceph kernel debug
>>>>> stuff you asked for) from a node boot with the rbd command hung for a
>>>>> couple of minutes:
>>>
>>> I'm sorry, but I did something stupid...
>>>
>>> Yes, the branch I gave you includes these fixes.  However
>>> it does *not* include the commit that was giving you trouble
>>> to begin with.
>>>
>>> So...
>>>
>>> I have updated that same branch (wip-nick) to contain:
>>> - Linux 3.5.5
>>> - Plus the first *50* (not 49) patches you listed
>>> - Plus the ones I added before.
>>>
>>> The new commit id for that branch begins with be3198d6.
>>>
>>> I'm really sorry for this mistake.  Please try this new
>>> branch and report back what you find.
>>>
>>>                                          -Alex
>>>
>>>
>>>> Nick, I have put together a branch that includes two fixes
>>>> that might be helpful.  I don't expect these fixes will
>>>> necessarily *fix* what you're seeing, but one of them
>>>> pulls a big hunk of processing out of the picture and
>>>> might help eliminate some potential causes.  I had to
>>>> pull in several other patches as prerequisites in order
>>>> to get those fixes to apply cleanly.
>>>>
>>>> Would you be able to give it a try, and let us know what
>>>> results you get?  The branch contains:
>>>> - Linux 3.5.5
>>>> - Plus the first 49 patches you listed
>>>> - Plus four patches, which are prerequisites...
>>>>      libceph: define ceph_extract_encoded_string()
>>>>      rbd: define some new format constants
>>>>      rbd: define rbd_dev_image_id()
>>>>      rbd: kill create_snap sysfs entry
>>>> - ...for these two bug fixes:
>>>>      libceph: remove 'osdtimeout' option
>>>>      ceph: don't reference req after put
>>>>
>>>> The branch is available in the ceph-client git repository
>>>> under the name "wip-nick" and has commit id dd9323aa.
>>>>      https://github.com/ceph/ceph-client/tree/wip-nick
>>>>
>>>>> https://raw.github.com/gist/4132395/7cb5f0150179b012429c6e57749120dd88616cce/gistfile1.txt
>>>>>
>>>>
>>>> This full debug output is very helpful.  Please supply
>>>> that again as well.
>>>>
>>>> Thanks.
>>>>
>>>>                                        -Alex
>>>>
>>>>> On Wed, Nov 21, 2012 at 9:49 PM, Nick Bartos <nick@pistoncloud.com>
>>>>> wrote:
>>>>>> It's very easy to reproduce now with my automated install script, the
>>>>>> most I've seen it succeed with that patch is 2 in a row, and hanging
>>>>>> on the 3rd, although it hangs on most builds.  So it shouldn't take
>>>>>> much to get it to do it again.  I'll try and get to that tomorrow,
>>>>>> when I'm a bit more rested and my brain is working better.
>>>>>>
>>>>>> Yes during this the OSDs are probably all syncing up.  All the osd
>>>>>> and
>>>>>> mon daemons have started by the time the rdb commands are ran,
>>>>>> though.
>>>>>>
>>>>>> On Wed, Nov 21, 2012 at 8:47 PM, Sage Weil <sage@inktank.com> wrote:
>>>>>>> On Wed, 21 Nov 2012, Nick Bartos wrote:
>>>>>>>> FYI the build which included all 3.5 backports except patch #50 is
>>>>>>>> still going strong after 21 builds.
>>>>>>>
>>>>>>> Okay, that one at least makes some sense.  I've opened
>>>>>>>
>>>>>>>          http://tracker.newdream.net/issues/3519
>>>>>>>
>>>>>>> How easy is this to reproduce?  If it is something you can
>>>>>>> trigger with
>>>>>>> debugging enabled ('echo module libceph +p >
>>>>>>> /sys/kernel/debug/dynamic_debug/control') that would help
>>>>>>> tremendously.
>>>>>>>
>>>>>>> I'm guessing that during this startup time the OSDs are still in the
>>>>>>> process of starting?
>>>>>>>
>>>>>>> Alex, I bet that a test that does a lot of map/unmap stuff in a
>>>>>>> loop while
>>>>>>> thrashing OSDs could hit this.
>>>>>>>
>>>>>>> Thanks!
>>>>>>> sage
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> On Wed, Nov 21, 2012 at 9:34 AM, Nick Bartos
>>>>>>>> <nick@pistoncloud.com> wrote:
>>>>>>>>> With 8 successful installs already done, I'm reasonably
>>>>>>>>> confident that
>>>>>>>>> it's patch #50.  I'm making another build which applies all
>>>>>>>>> patches
>>>>>>>>> from the 3.5 backport branch, excluding that specific one. 
>>>>>>>>> I'll let
>>>>>>>>> you know if that turns up any unexpected failures.
>>>>>>>>>
>>>>>>>>> What will the potential fall out be for removing that specific
>>>>>>>>> patch?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Wed, Nov 21, 2012 at 9:02 AM, Nick Bartos
>>>>>>>>> <nick@pistoncloud.com> wrote:
>>>>>>>>>> It's really looking like it's the
>>>>>>>>>> libceph_resubmit_linger_ops_when_pg_mapping_changes commit.  When
>>>>>>>>>> patches 1-50 (listed below) are applied to 3.5.7, the hang is
>>>>>>>>>> present.
>>>>>>>>>>   So far I have gone through 4 successful installs with no
>>>>>>>>>> hang with
>>>>>>>>>> only 1-49 applied.  I'm still leaving my test run to make sure
>>>>>>>>>> it's
>>>>>>>>>> not a fluke, but since previously it hangs within the first
>>>>>>>>>> couple of
>>>>>>>>>> builds, it really looks like this is where the problem
>>>>>>>>>> originated.
>>>>>>>>>>
>>>>>>>>>> 1-libceph_eliminate_connection_state_DEAD.patch
>>>>>>>>>> 2-libceph_kill_bad_proto_ceph_connection_op.patch
>>>>>>>>>> 3-libceph_rename_socket_callbacks.patch
>>>>>>>>>> 4-libceph_rename_kvec_reset_and_kvec_add_functions.patch
>>>>>>>>>> 5-libceph_embed_ceph_messenger_structure_in_ceph_client.patch
>>>>>>>>>> 6-libceph_start_separating_connection_flags_from_state.patch
>>>>>>>>>> 7-libceph_start_tracking_connection_socket_state.patch
>>>>>>>>>> 8-libceph_provide_osd_number_when_creating_osd.patch
>>>>>>>>>> 9-libceph_set_CLOSED_state_bit_in_con_init.patch
>>>>>>>>>> 10-libceph_embed_ceph_connection_structure_in_mon_client.patch
>>>>>>>>>> 11-libceph_drop_connection_refcounting_for_mon_client.patch
>>>>>>>>>> 12-libceph_init_monitor_connection_when_opening.patch
>>>>>>>>>> 13-libceph_fully_initialize_connection_in_con_init.patch
>>>>>>>>>> 14-libceph_tweak_ceph_alloc_msg.patch
>>>>>>>>>> 15-libceph_have_messages_point_to_their_connection.patch
>>>>>>>>>> 16-libceph_have_messages_take_a_connection_reference.patch
>>>>>>>>>> 17-libceph_make_ceph_con_revoke_a_msg_operation.patch
>>>>>>>>>> 18-libceph_make_ceph_con_revoke_message_a_msg_op.patch
>>>>>>>>>> 19-libceph_fix_overflow_in___decode_pool_names.patch
>>>>>>>>>> 20-libceph_fix_overflow_in_osdmap_decode.patch
>>>>>>>>>> 21-libceph_fix_overflow_in_osdmap_apply_incremental.patch
>>>>>>>>>> 22-libceph_transition_socket_state_prior_to_actual_connect.patch
>>>>>>>>>> 23-libceph_fix_NULL_dereference_in_reset_connection.patch
>>>>>>>>>> 24-libceph_use_con_get_put_methods.patch
>>>>>>>>>> 25-libceph_drop_ceph_con_get_put_helpers_and_nref_member.patch
>>>>>>>>>> 26-libceph_encapsulate_out_message_data_setup.patch
>>>>>>>>>> 27-libceph_encapsulate_advancing_msg_page.patch
>>>>>>>>>> 28-libceph_don_t_mark_footer_complete_before_it_is.patch
>>>>>>>>>> 29-libceph_move_init_bio__functions_up.patch
>>>>>>>>>> 30-libceph_move_init_of_bio_iter.patch
>>>>>>>>>> 31-libceph_don_t_use_bio_iter_as_a_flag.patch
>>>>>>>>>> 32-libceph_SOCK_CLOSED_is_a_flag_not_a_state.patch
>>>>>>>>>> 33-libceph_don_t_change_socket_state_on_sock_event.patch
>>>>>>>>>> 34-libceph_just_set_SOCK_CLOSED_when_state_changes.patch
>>>>>>>>>> 35-libceph_don_t_touch_con_state_in_con_close_socket.patch
>>>>>>>>>> 36-libceph_clear_CONNECTING_in_ceph_con_close.patch
>>>>>>>>>> 37-libceph_clear_NEGOTIATING_when_done.patch
>>>>>>>>>> 38-libceph_define_and_use_an_explicit_CONNECTED_state.patch
>>>>>>>>>> 39-libceph_separate_banner_and_connect_writes.patch
>>>>>>>>>> 40-libceph_distinguish_two_phases_of_connect_sequence.patch
>>>>>>>>>> 41-libceph_small_changes_to_messenger.c.patch
>>>>>>>>>> 42-libceph_add_some_fine_ASCII_art.patch
>>>>>>>>>> 43-libceph_set_peer_name_on_con_open_not_init.patch
>>>>>>>>>> 44-libceph_initialize_mon_client_con_only_once.patch
>>>>>>>>>> 45-libceph_allow_sock_transition_from_CONNECTING_to_CLOSED.patch
>>>>>>>>>> 46-libceph_initialize_msgpool_message_types.patch
>>>>>>>>>> 47-libceph_prevent_the_race_of_incoming_work_during_teardown.patch
>>>>>>>>>>
>>>>>>>>>> 48-libceph_report_socket_read_write_error_message.patch
>>>>>>>>>> 49-libceph_fix_mutex_coverage_for_ceph_con_close.patch
>>>>>>>>>> 50-libceph_resubmit_linger_ops_when_pg_mapping_changes.patch
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On Wed, Nov 21, 2012 at 8:50 AM, Sage Weil <sage@inktank.com>
>>>>>>>>>> wrote:
>>>>>>>>>>> Thanks for hunting this down.  I'm very curious what the
>>>>>>>>>>> culprit is...
>>>>>>>>>>>
>>>>>>>>>>> sage
>>>>>>>>
>>>>>>>>
>>>>
>>>
> 

