From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: bluestore onode diet and encoding overhead
Date: Thu, 14 Jul 2016 14:14:17 +0000
Message-ID: <BY2PR0201MB1525E65D316A3DAC17046005E8320@BY2PR0201MB1525.namprd02.prod.outlook.com>
References: <9b80fe95-9da5-bffe-c869-a7ba51da70b3@redhat.com>
 <BLUPR0201MB1524775973993917A1A59078E8300@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1607121658240.497@piezo.us.to>
 <0b770e1d-5b3a-b9d1-175c-ccec29ee1737@redhat.com>
 <BY2PR0201MB15253B6976C145EA325489AAE8320@BY2PR0201MB1525.namprd02.prod.outlook.com>
 <47c4376f-a958-9cb6-9bd1-c9ac4a56ac35@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam02on0088.outbound.protection.outlook.com ([104.47.36.88]:14016
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751160AbcGNOOU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jul 2016 10:14:20 -0400
In-Reply-To: <47c4376f-a958-9cb6-9bd1-c9ac4a56ac35@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

w.r.t. allocation, yes -- exactly. Here's a snippet from my previous e-mail that completes the picture:

Fundamentally, the problem that we have is lack of knowledge about how much data is going to be encoded (and to a lesser extent, decoded). Currently, we basically check for space on each micro-encode operation. Clearly those checks have to be eliminated. That leaves us with basically three choices:

(1) Pre-allocate a buffer sufficiently large.
(2) Check for sufficient space at "strategic" places in the code.
(3) Fiddle with the CPU memory mapping tables to generate a page fault when we run off the end of our buffer (which clearly must be page aligned, blah blah blah) and then contrive to auto-allocate and restart.

I reject (3) as too complex and not worth the effort.

I reject (2) as difficult to maintain and difficult to determine where the "strategic" points in the code are that retain correctness, but happen infrequently enough to minimize CPU utilization. 

That leaves us with (1).

Method (1) must consist of making a worst-case prediction of the size of the encoded data. Encoded the data into the allocated buffer and then "freeing" the unused portion (since tight encoding of the data is content-dependent in length). The encode and free processes are relatively straightforward, but the prediction process has some options to explore.

(1a) Constant "maximum". We could easily establish something like a 128K or 256K constant upper limit and just use a buffer of that size.
(1b) computed "maximum", For simple objects (a few fields/containers) it's relatively easy to add up the necessary sizes to generate an estimate. For complex objects, this is error prone because you're duplicating the encode with the estimate-size logic.

Right now, I'm trying to concoct some combinations of C++ templates that's lets me merge the estimate-size, encode and decode functions into a common routine so that we can avoid this system-matic error. Stay tuned.

One of the dangers of the prediction scheme is what if the prediction is incorrect -- too small. Then you'll get buffer overrun. It's been suggested that we insert some special debug-assert code to detect that situation which is only enabled at compile-time. I believe this is NOT the right solution. The buffer overrun problem is data dependent. That means it will be especially hard to debug in the field as what you're looking for is essentially silent data corruption.

I believe that the best solution is to simply check the fully-encoded buffer against the estimate that was made. If the estimate is too small, then assert-out. Leave this in production code. If we encounter an encode-buffer overrun at least we'll now that was the source of the problem and we can fix it. (I assert that if you see this, it'll be pretty obvious where it went wrong -- especially if I'm able to create a unified estimate-size, encode and decode function.

One last problem to solve is the decode problem. We need to know how much data is in a fast-encode buffer in order to ensure that it's not fragmented in the buffer::list. This is relatively easy if the encode leaves a "total bytes" field at the start of the operation.

Now we can see the pseudo-code for fast-encode.

Void fast_encode(object& o, bufferptr& b) {
   size_t estimate = o.estimate_sizeof_fast_encode() + sizeof(int);  // Extra int is for explicit size of the overall buffer.
   char * buf_start = b.push_back (estimate);	// returns pointer to a block of memory appended to the end that's of the specified size;
   char * buf_end  = o.do_fast_encode(buf_start + sizeof(int)); // starts serialization into the address pointed at by the input parameter, returns "next" pointer, i.e., pointer to next unused byte 
   size_t consumed = buf_end - buf_start; // Compute consumed bytes

   assert(consumed <= estimate);  // Here's where we catch a silent data corruption due to an overflow

   *(int *)buf_start = consumed;  // Total size of consumed buffer, including the starting int stored back at the start...

   size_t unused = estimate - consumed; // Amount of unused space at the end.

   b.pop_back(unused); // "free" the unused bytes at the end of the buffer.

}

Now we can see the shape of the fast_decode function.

Void fast_decode(object& o, bufferptr& b) {
   
   Int encode_size = b.pop_front_int();   // Remove first bytes where the encode left the size of the full buffer

   const char *buf_start = b.contiguous_ptr(encode_size - sizeof(int));   // return pointer to sequential buffer of specified number of bytes <<<<- here's where we might have to copy discontiguous buffers into a single buffer.

   const char *buf_end = o.fast_decode(buf_start);		              // Decode data from the buffer into the object, return the pointer to the last consumed byte.

   Size_t consumed_bytes = buf_end - buf_start;
  
  Assert(consumed_bytes == encode_size);			// Consistency check, we consumed exactly as much as we encoded (NB, I may have left off a " + sizeof(int)" for the initial buffer size.)

   b.pop_front(consumed_bytes);				// logically remove the bytes that we've consumed

}



Allen Samuels
SanDisk |a Western Digital brand
2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com


> -----Original Message-----
> From: Mark Nelson [mailto:mnelson@redhat.com]
> Sent: Thursday, July 14, 2016 4:16 AM
> To: Allen Samuels <Allen.Samuels@sandisk.com>; Sage Weil
> <sweil@redhat.com>
> Cc: ceph-devel <ceph-devel@vger.kernel.org>
> Subject: Re: bluestore onode diet and encoding overhead
> 
> On 07/14/2016 12:52 AM, Allen Samuels wrote:
> > As promised, here's some code that hacks out a new encode/decode
> framework. That has the advantage of only having to list the fields of a struct
> once and is pretty much guaranteed to never overrun a buffer....
> >
> > Comments are requested :)
> 
> It compiles! :D
> 
> I looked over the code, but I want to look it over again after I've had my
> coffee since I'm still shaking the cobwebs out.  Would the idea here be that if
> you are doing varint encoding for example that you always allocate the
> buffer based on ESTIMATE (also taking into account the encoding overhead),
> but typically expect a much smaller encoding?
> 
> As it is, it's very clever.
> 
> Mark
> 
> >
> >
> > #include <iostream>
> > #include <fstream>
> > #include <set>
> > #include <string>
> > #include <string.h>
> >
> > /*******************************************************
> >
> >
> >    New fast encode/decode framework.
> >
> >    The entire framework is built around the idea that each object has three
> operations:
> >
> >      ESTIMATE  -- worst-case estimate of the amount of storage required for
> this object
> >      ENCODE    -- encode object into buffer of size ESTIMATE
> >      DECODE    -- encode object from buffer of size actual.
> >
> >    Each object has a single templated function that actually provides all three
> operations in a single set of code.
> >    But doing this, it's pretty much guaranteed that the ESTIMATE and the
> ENCODE code are in harmony (i.e. that the estimate is correct)
> >    it also saves a lot of typing/reading...
> >
> >    Generally, all three operations are provided on a single function name
> with the input and return parameters overloaded to distinguish them.
> >
> >    It's observed that for each of the three operations there is a single value
> which needs to be transmitted between each of the micro-encode/decode
> calls
> >    Yes, this is confusing, but let's look at a simple example
> >
> >     struct simple {
> >       int a;
> >       float b;
> >       string c;
> >       set<int> d;
> >     };
> >
> >     To encode this struct we generate a function that does the micro-
> encoding of each of the fields of the struct
> >     Here's an example of a function that does the ESTIMATE operation.
> >
> >     size_t simple::estimate() {
> >        return
> >           sizeof(a) +
> >           sizeof(b) +
> >           c.size() +
> >           d.size() * sizeof(int);
> >     }
> >
> >     We're going to re-write it as:
> >
> >     size_t simple::estimate(size_t p) {
> >        p = estimate(p,a);
> >        p = estimate(p,b);
> >        p = estimate(p,c);
> >        p = estimate(p,d);
> >        return p;
> >     }
> >
> >     assuming that the sorta function:
> >
> >     template<typename t> size_t estimate(size_t p,t& o) { return p +
> sizeof(o); }
> >     template<typename t> size_t estimate(size_t p,set<t>& o) { return
> > p + o.size() * sizeof(t); }
> >
> >
> >     similarly, the encode operation is represented as:
> >
> >     char * simple::encode(char *p) {
> >        p = encode(p,a);
> >        p = encode(p,b);
> >        p = encode(p,c);
> >        p = encode(p,d);
> >        return p;
> >     }
> >
> >     similarly, the decode operation is represented as:
> >
> >     const char * simple::decode(const char *p) {
> >        p = decode(p,a);
> >        p = decode(p,b);
> >        p = decode(p,c);
> >        p = decode(p,d);
> >        return p;
> >     }
> >
> >
> > You can now see that it's possible to create a single function that
> > does all three operations in a single block of code, provided that you can
> fiddle the input/output parameter types appropriately.
> >
> > In essence the pattern is
> >
> >     p = enc_dec(p,struct_field_1);
> >     p = enc_dec(p,struct_field_2);
> >     p = enc_dec(p,struct_field_3);
> >
> > With the type of p being set differently for each operation, i.e.,
> >     for ESTIMATE, p = size_t
> >     for ENCODE,   p = char *
> >     for DECODE,   p = const char *
> >
> > This is the essence of how the encode/decode framework operates.
> Though there is some more sophistication...
> >
> > ----------------------
> >
> > We also want to allow the encode/decode machinery to be per-type and
> > to operate
> >
> >
> **********************************************************
> ************
> > *******/
> >
> > using namespace std;
> >
> > //
> > // Just like the existing encode/decode machinery. The environment
> > provides a rich set of // pre-defined encodes for primitive types and
> > containers //
> >
> > #define DEFINE_ENC_DEC_RAW(type) \
> > inline size_t      enc_dec(size_t p,type &o)      { return p + sizeof(type); } \
> > inline char *      enc_dec(char *p, type &o)      { *(type *)p = o; return p +
> sizeof(type); } \
> > inline const char *enc_dec(const char *p,type &o) { o = *(const type
> > *)p; return p + sizeof(type); }
> >
> > DEFINE_ENC_DEC_RAW(int);
> > DEFINE_ENC_DEC_RAW(size_t);
> >
> > //
> > // String encode/decode (Yea, I know size_t isn't portable -- this is
> > an EXAMPLE man...) // inline size_t enc_dec(size_t p,string& s) {
> > return p + sizeof(size_t) + s.size(); } inline char * enc_dec(char *
> > p,string& s) { *(size_t *)p = s.size();
> > memcpy(p+sizeof(size_t),s.c_str(),s.size()); return p + sizeof(size_t)
> > + s.size(); } inline const char *enc_dec(const char *p,string& s) { s
> > = string(p + sizeof(size_t),*(size_t *)p); return p + sizeof(size_t) +
> > s.size(); }
> >
> > //
> > // Let's do a container.
> > //
> > // One of the problems with a container is that making an accurate
> > estimate of the size // would theoretically require that you walk the entire
> container and add up the sizes of each element.
> > // We probably don't want to do that. So here, I do a hack that just
> > assumes that I can fake up a individual element // and multiple that
> > by the number of elements in a container. This hack works anytime that
> > the estimate function // for the contained type has a fixed maximum size.
> BTW, this is safe, if the contained type has a variable size //  (like set<string>)
> then it will fault out the first time you run it.
> > //
> > // Naturally, something like set<string> or map<string,string> is a
> > highly desirable thing to be able to encode/decode // there's no reason
> that you can't create a enc_dec_slow function that properly computes the
> maximum size by walking the container.
> > //
> > template<typename t>
> > inline size_t enc_dec(size_t p,set<t>& s) { return p + sizeof(size_t)
> > + (s.size() * ::enc_dec(size_t(0),*(t *) 0)); }
> >
> > template<typename t>
> > inline char *enc_dec(char *p,set<t>& s) {
> >    size_t sz = s.size();
> >    p = enc_dec(p,sz);
> >    for (const t& e : s) {
> >       p = enc_dec(p,const_cast<t&>(e));
> >    }
> >    return p;
> > }
> >
> > template<typename t>
> > inline const char *enc_dec(const char *p,set<t>&s) {
> >    size_t sz;
> >    p = enc_dec(p,sz);
> >    while (sz--) {
> >       t temp;
> >       p = enc_dec(p,temp);
> >       s.insert(temp);
> >    }
> >    return p;
> > }
> >
> > //
> > // Specialized encode/decode for a single data type. These are invoked
> explicitly...
> > //
> > inline size_t enc_dec_lba(size_t p,int& lba) {
> >    return p + sizeof(lba); // Max....
> > }
> >
> > inline char * enc_dec_lba(char *p,int& lba) {
> >    *p = 15;
> >    return p + 1; // blah blah
> > }
> >
> > inline const char *enc_dec_lba(const char *p,int& lba) {
> >    lba = *p;
> >    return p+1;
> > }
> >
> > //
> > // Specialized encode/decode for more sophisticated things primitives.
> > //
> > // Here's an example of a encode/decoder for a pair of fields //
> > inline size_t enc_dec_range(size_t p,short& start,short& end) {
> >    return p + 2 * sizeof(short);
> > }
> >
> > inline char *enc_dec_range(char *p, short& start, short& end) {
> >    short *s = (short *) p;
> >    s[0] = start;
> >    s[1] = end;
> >    return p + sizeof(short) * 2;
> > }
> >
> > inline const char *enc_dec_range(const char *p,short& start, short& end) {
> >    start = *(short *)p;
> >    end   = *(short *)(p + sizeof(short));
> >    return p + 2*sizeof(short);
> > }
> >
> >
> > //
> > // Some C++ template wizardry to make the single encode/decode
> function possible.
> > //
> > enum SERIAL_TYPE {
> >    ESTIMATE,
> >    ENCODE,
> >    DECODE
> > };
> >
> > template <enum SERIAL_TYPE s> struct serial_type;
> >
> > template<> struct serial_type<ESTIMATE> { typedef size_t type; };
> > template<> struct serial_type<ENCODE>   { typedef char * type; };
> > template<> struct serial_type<DECODE>   { typedef const char *type; };
> >
> > //
> > // This macro is the key, it connects the external non-member function to
> the correct member function.
> > //
> > #define DEFINE_STRUCT_ENC_DEC(s) \
> > inline size_t      enc_dec(size_t p, s &o) { return o.enc_dec<ESTIMATE>(p); }
> \
> > inline char *      enc_dec(char *p , s &o)  { return o.enc_dec<ENCODE>(p); }
> \
> > inline const char *enc_dec(const char *p,s &o)  { return
> > o.enc_dec<DECODE>(p); }
> >
> > //
> > // Our example structure
> > //
> > struct astruct {
> >    int a;
> >    set<int> b;
> >    int lba;
> >    short start,end;
> >
> >    //
> >    // <<<<< You need to provide this function just one.
> >    //
> >    template<enum SERIAL_TYPE s> typename serial_type<s>::type
> enc_dec(typename serial_type<s>::type p) {
> >       p = ::enc_dec(p,a);
> >       p = ::enc_dec(p,b);
> >       p = ::enc_dec_lba(p,lba);
> >       p = ::enc_dec_range(p,start,end);
> >       return p;
> >    }
> > };
> >
> > //
> > // This macro connects the global enc_dec to the member function.
> > // One of these per struct declaration //
> > DEFINE_STRUCT_ENC_DEC(astruct);
> >
> >
> > //
> > // Here's a simple test program. The real encode/decode framework
> > needs to be connected to bufferlist using the pseudo-code // that I
> documented in my previous email.
> > //
> >
> > int main(int argc,char **argv) {
> >
> >    astruct a;
> >    a.a = 10;
> >    a.b.insert(2);
> >    a.b.insert(3);
> >    a.lba = 12;
> >
> >    size_t s = a.enc_dec<ESTIMATE>(size_t(0));
> >    cout << "Estimated size is " << s << "\n";
> >
> >    char buffer[100];
> >
> >    char *end = a.enc_dec<ENCODE>(buffer);
> >
> >    cout << "Actual storage was " << end-buffer << "\n";
> >
> >    astruct b;
> >
> >    (void) b.enc_dec<DECODE>(buffer); // decode it
> >
> >    cout << "A.a = " << b.a << "\n";
> >    for (auto e : b.b) {
> >       cout << " " << e;
> >    }
> >
> >    cout << "\n";
> >
> >    cout << "a.lba = " << b.lba << "\n";
> >
> >    return 0;
> > }
> >
> >
> > Allen Samuels
> > SanDisk |a Western Digital brand
> > 2880 Junction Avenue, San Jose, CA 95134
> > T: +1 408 801 7030| M: +1 408 780 6416 allen.samuels@SanDisk.com
> >
> >
> >> -----Original Message-----
> >> From: Mark Nelson [mailto:mnelson@redhat.com]
> >> Sent: Tuesday, July 12, 2016 8:13 PM
> >> To: Sage Weil <sweil@redhat.com>; Allen Samuels
> >> <Allen.Samuels@sandisk.com>
> >> Cc: ceph-devel <ceph-devel@vger.kernel.org>
> >> Subject: Re: bluestore onode diet and encoding overhead
> >>
> >>
> >>
> >> On 07/12/2016 08:50 PM, Sage Weil wrote:
> >>> On Tue, 12 Jul 2016, Allen Samuels wrote:
> >>>> Good analysis.
> >>>>
> >>>> My original comments about putting the oNode on a diet included the
> >>>> idea of a "custom" encode/decode path for certain high-usage cases.
> >>>> At the time, Sage resisted going down that path hoping that a more
> >>>> optimized generic case would get the job done. Your analysis shows
> >>>> that while we've achieved significant space reduction this has come
> >>>> at the expense of CPU time -- which dominates small object
> >>>> performance (I suspect that eventually we'd discover that the
> >>>> variable length decode path would be responsible for a substantial
> >>>> read performance degradation also -- which may or may not be part of
> >>>> the read performance drop-off that you're seeing). This isn't a
> surprising
> >> result, though it is unfortunate.
> >>>>
> >>>> I believe we need to revisit the idea of custom encode/decode paths
> >>>> for high-usage cases, only now the gains need to be focused on CPU
> >>>> utilization as well as space efficiency.
> >>>
> >>> I still think we can get most or all of the way there in a generic way
> >>> by revising the way that we interact with bufferlist for encode and
> decode.
> >>> We haven't actually tried to optimize this yet, and the current code
> >>> is pretty horribly inefficient (asserts all over the place, and many
> >>> layers of pointer indirection to do a simple append).  I think we need
> >>> to do two
> >>> things:
> >>>
> >>> 1) decode path: optimize the iterator class so that it has a const
> >>> char *current and const char *current_end that point into the current
> >>> buffer::ptr.  This way any decode will have a single pointer
> >>> add+comparison to ensure there is enough data to copy before falling
> >>> add+into
> >>> the slow path (partial buffer, move to next buffer, etc.).
> >>>
> >>
> >> I don't have a good sense yet for how much this is hurting us in the read
> >> path.  We screwed something up in the last couple of weeks and small
> reads
> >> are quite slow.
> >>
> >>> 2) Having that comparison is still not ideal, but we shoudl consider
> >>> ways to get around that too.  For example, if we know that we are
> >>> going to decode N M-byte things, we could do an iterator 'reserve' or
> >>> 'check' that ensures we have a valid pointer for that much and then
> >>> proceed without checks.  The interface here would be tricky, though,
> >>> since in the slow case we'll span buffers and need to magically fall
> >>> back to a different decode path (hard to maintain) or do a temporary
> >>> copy (probably faster but we need to ensure the iterator owns it and
> >>> frees is later).  I'd say this is step 2 and optional; step 1 will have the most
> >> benefit.
> >>>
> >>> 3) encode path: currently all encode methods take a bufferlist& and
> >>> the bufferlist itself as an append buffer.  I think this is flawed and
> >>> limiting.  Instead, we should make a new class called
> >>> buffer::list::appender (or similar) and templatize the encode methods
> >>> so they can take a safe_appender (which does bounds checking) or an
> >>> unsafe_appender (which does not).  For the latter, the user takes
> >>> responsibility for making sure there is enough space by doing a
> >>> reserve() type call which returns an unsafe_appender, and it's their
> >>> job to make sure they don't shove too much data into it.  That should
> >>> make the encode path a memcpy + ptr increment (for savvy/optimized
> >> callers).
> >>
> >> Seems reasonable and similar in performance to what Piotr and I were
> >> discussing this morning.  As a very simple test I was thinking of doing a
> quick
> >> size computation and then passing that in to increase the append_buffer
> size
> >> when the bufferlist is created in Bluestore::_txc_write_nodes.  His idea
> went
> >> a bit farther to break the encapsulation, compute the fully encoded
> >> message, and dump it directly into a buffer of a computed size without
> the
> >> extra assert checks or bounds checking.  Obviously his idea would be
> faster
> >> but more work.
> >>
> >> It sounds like your solution would be similar but a bit more formalized.
> >>
> >>>
> >>> I suggest we use bluestore as a test case to make the interfaces work
> >>> and be fast.  If we succeed we can take advantage of it across the
> >>> reset of the code base as well.
> >>
> >> Do we have other places in the code with similar byte append behavior?
> >> That's what's really killing us I think, especially with how small the new
> >> append_buffer is when you run out of space when appending bytes.
> >>
> >>>
> >>> That's my thinking, at least.  I haven't had time to prototype it out
> >>> yet, but I think our goal should be to make the encode/decode paths
> >>> capable of being a memcpy + ptr addition in the fast path, and let
> >>> that guide the interface...
> >>>
> >>> sage
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> >>> in the body of a message to majordomo@vger.kernel.org More
> >> majordomo
> >>> info at  http://vger.kernel.org/majordomo-info.html
> >>>
