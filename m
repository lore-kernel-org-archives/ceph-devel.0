From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Fwd: wip-hint
Date: Tue, 25 Feb 2014 11:18:01 -0800
Message-ID: <CABBk=J9acfgE8BsO7YkNcK8d8o4yoXJWnYkYRPD3N=wEs1w5Tg@mail.gmail.com>
References: <alpine.DEB.2.00.1402230742470.17508@cobra.newdream.net>
	<CABBk=J-o-hcyUZzoDDvCV=+YJyUunKmDobDUtSAnsWnEMxYp_A@mail.gmail.com>
	<CABBk=J8o5kpOHu4mVPizf4ACSZMu7XOMTu_OtL5sSpeVjmXHJQ@mail.gmail.com>
	<alpine.DEB.2.00.1402231113430.17508@cobra.newdream.net>
	<CABBk=J_=V+sDg_Z8aiTxHA3Rv7ygt=ePipG_YoHTSzYUG8Y2wQ@mail.gmail.com>
	<alpine.DEB.2.00.1402240521510.17508@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f169.google.com ([209.85.128.169]:62238 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbaBYTSD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 14:18:03 -0500
Received: by mail-ve0-f169.google.com with SMTP id c14so1007883vea.28
        for <ceph-devel@vger.kernel.org>; Tue, 25 Feb 2014 11:18:02 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1402240521510.17508@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

This was discussed off list, but here's my take:

On Tue, Feb 25, 2014 at 9:38 AM, Sage Weil <sage@inktank.com> wrote:
> On Sun, 23 Feb 2014, Yehuda Sadeh wrote:
>> On Sun, Feb 23, 2014 at 11:25 AM, Sage Weil <sage@inktank.com> wrote:
>> > On Sun, 23 Feb 2014, Yehuda Sadeh wrote:
>> >> (resending to get through the list) My main concern is that the whole
>> >> notion of hint needs to be abstracted. Instead of having a specific op
>> >> for allocation hints we should have a generic hint operation that
>> >> would contain a hint type in it. That hint will then be parsed within
>> >> the various osd components, and will be used if identified and if
>> >> needed. Then you'd be able to add various hints without needing to
>> >> change the  protocol itself.
>> >> Not sure if the operation itself needs to have a "write" flag set on it,
>> >> as hints may apply to read operations too (e.g., a hint to prefetch data
>> >> read). We may want to create two different ops, one for read and one for
>> >> write. I think that a first step would be to modify the current op and
>> >> add a "hint type" string at the data portion, and an optional bufferlist
>> >> for data. The size params need to be generic and not specific (param1,
>> >> param2, ...).
>> >
>> > The nice thing about adding a new rados op is that there isn't any
>> > disruptive protocol change.  Practically speaking, there isn't a big
>> > difference between adding one new hint op that is extensible and utilizing
>> > the (already extensible) rados op infrastructure.  Mostly it just means
>> > that the allocation hint is nicely named and parameterized for this
>> > particular purpose without precluding the ability to add other ops later.
>> > In the read-side hint case I think we should be particularly careful about
>> > using things like flags to make it trivial to add new behaviors, but I
>> > don't see a benefit to smoshing those sorts of hints together with
>> > allocation hints when the alloc stuff is clearly different.
>> >
>> > That said, I think it *is* important whether we are nice and general
>> > about alloc hints in this op.  We can add new fields to the args union as
>> > needed (up to a point), and can always add an setallochint2 op, but if
>> > there is something obvious missing..
>> >
>>
>> The current op is very specialized and I'm having trouble to see how
>> it could later be extended. Basically it just passes the following:
>
> This is really:
>
> opcode/type = ALLOC_HINT
>> __le64 expected_size;
>> __le64 expected_write_size;
>> __u8 expected_size_probability;
>
>> Thinking about future librados application developers that will also
>> need to tie the osd into some specialized backend with its own quirks.
>> For example., an allocation hint might need to specify that writes
>> need to be interleaved by sectors, with some special ordering, or that
>> writes will be done directly on the block storage with some specific
>> alignment.
>
> We can add fields to this, for example by adding
>
>         __le32 alignment;
>
> to the args for this particular opcode.


That was just an example.
>
>> Now, I don't think it would be possible for these users to add new rados
>> ops, and otoh, the current info that this specific operation is
>> insufficient. So at the minimum we're missing a 'hint type' info here.
>
> That's the rados opcode.  And we can add rados opcodes whenever we want,
> specifically when we add support on the backend.  Any ops marked with
> FAILOK will be ignored if they are not understood.
>
> Basically, at *some* level, we need to have a switch where there is a
> 'type' and we define the various parameters for that particular type of
> hint.  We can either
>
> 1- define a catch-all 'hint' op at the rados level, and then start
> defining specific types and their params, starting with something for
> allocation hints.
>
> 2- use the existing framework for rados ops and use that as the 'type'.
>
> This patch takes option 2 because all the generic work is already done at
> the rados level and we can easily add new ops and ignore ones that we
> don't understand at the server side.

Of course we can add new ops for everything, but can't practically do
that. At one point we'd have some of these that would use the osd as a
black box and requiring them to recompile it for that purpose is not
an option.

>
> I agree that having a full pass-through would also be useful, and we can
> add that later (probably around the time when we have pluggable backends
> that might understand it).  I'm not sure what we would gain from doing the
> switch on hint type underneath a catch-all rados op.  If nothing else, we
> already would have to have 2 since some hints are 'write' hints and need
> to be treated a bit differently by the OSD.
>

You're basically limiting this specific op to this specific hint. In
the future we're almost certain to have more hints, which means that
we'll need to create new op codes. So we'll have more code paths that
will basically do the same. This is not very generic, and I don't
think it is the right way forward.

As I see it, we'd need to make this op more general, something like this:

struct ceph_osd_op {

...

#define OSD_HINT_TYPE_PASSTHROUGH     1
#define OSD_HINT_TYPE_ALLOC_SIZE          2

#define OS_HINT_FLAG_EXTRA_DATA 0x1

struct {
  __le32 hint_type;
  __le32 hint_flags;
 __le64 param1;
 __le64 param2;
} __attribute__ ((packed)) hint;


The extra data will be put in the op data portion (corresponding bit
will need to be set):

struct osd_op_hint_extra_data {
  string hint_name;
  bufferlist bl;

  void encode(...);
  void decode(...);
};


And the following structure will be set:

struct OSDHint {
  uint32_t type;
  uint64_t param1;
  uint64_t param2;
  string name;
  bufferlist bl;
};

This structure will be available all through when a request is being
processed in the osd, leaving it to the different layers to decide
whether it needs to be handled there or not. That will include any osd
backend provider.

A new librados op will be created for this op, and will basically
encode the different params. So at this point we'll have client ->
backend channel that will not require any osd recompilation.

How far is the current code to support this op? Basically missing the
type and flag fields, and need to check for the actual type.
Everything else can be added later in future versions. I understand
that we can just add the complete op later, but that'll just add
unnecessary code duplication later.


Yehuda
