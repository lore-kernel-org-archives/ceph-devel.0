From: David Zafman <dzafman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: inconsistent pg will not repair
Date: Tue, 26 Sep 2017 12:16:51 -0700
Message-ID: <61c697d9-2c0e-d694-3bfb-df8b2338606c@redhat.com>
References: <CAGbvivJWLXaGzZjAFLpqBFP9N7QHkYt8uZyo9z3qpSnrHz8YZQ@mail.gmail.com>
 <CAJ4mKGbx1pEWd0b+99t0tmjLanjSUe9OmChWoTgthAkqyVurGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4415211428040333642=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAJ4mKGbx1pEWd0b+99t0tmjLanjSUe9OmChWoTgthAkqyVurGA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Wyllys Ingersoll <wyllys.ingersoll-yfee5r9JHcEqDJ6do+/SaQ@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============4415211428040333642==
Content-Type: multipart/alternative;
 boundary="------------9C8D105355CD934850E61BBD"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------9C8D105355CD934850E61BBD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


The following is based on the discussion in: 
http://tracker.ceph.com/issues/21388

------

There is a particular scenario which if identified can be repaired 
manually. In this case the automatic repair rejects all copies because 
none match the selected_object_info thus setting data_digest_mismatch_oi 
on all shards.

Doing the following should produce list-inconsistent-obj information:

$ ceph pg deep-scrub 1.0
(Wait for scrub to finish)
$ rados list-inconsistent-obj 1.0 --format=json-pretty

Requirements:

 1. data_digest_mismatch_oi is set on all shards make it unrepairable
 2. union_shard_errors has only data_digest_mismatch_oi listed, no other
    issues involved
 3. Object "errors" is empty { "inconsistent": [ { ..."errors": []....}
    ] } which means the data_digest value is the same on all shards
    (0x2d4a11c2 in the example below)
 4. No down OSDs which might have different/correct data

To fix use rados get/put followed by a deep-scrub to clear the 
"inconsistent" pg state.  Use -b option with a value smaller than the 
file size so that the read doesn't compare the digest and return EIO.

 1. rados -p pool -b 10240 get mytestobject tempfile
 2. rados -p pool put mytestobject tempfile
 3. ceph pg deep-scrub 1.0


Here is an example list-inconsistent-obj output of what this scenario 
looks like:

{ "inconsistents": [ { "shards": [ { "data_digest": "0x2d4a11c2", 
"omap_digest": "0xf5fba2c6", "size": 143456, "errors": [ 
"data_digest_mismatch_oi" ], "osd": 0, "primary": true }, { 
"data_digest": "0x2d4a11c2", "omap_digest": "0xf5fba2c6", "size": 
143456, "errors": [ "data_digest_mismatch_oi" ], "osd": 1, "primary": 
false }, { "data_digest": "0x2d4a11c2", "omap_digest": "0xf5fba2c6", 
"size": 143456, "errors": [ "data_digest_mismatch_oi" ], "osd": 2, 
"primary": false } ], "selected_object_info": "3:ce3f1d6a::: 
mytestobject:head(47'54 osd.0.0:53 dirty|omap|data_digest|omap_digest s 
143456 uv 3 dd 2ddbf8f5 od f5fba2c6 alloc_hint [0 0 0])", 
"union_shard_errors": [ "data_digest_mismatch_oi" ], "errors": [ ], 
"object": { "version": 3, "snap": "head", "locator": "", "nspace": "", 
"name": "mytestobject" } } ], "epoch": 103443 }


David

On 9/26/17 10:55 AM, Gregory Farnum wrote:
> [ Re-send due to HTML email part]
>
> IIRC, this is because the object info and the actual object disagree
> about what the checksum should be. I don't know the best way to fix it
> off-hand but it's been discussed on the list (try searching for email
> threads involving David Zafman).
> -Greg
>
> On Tue, Sep 26, 2017 at 7:03 AM, Wyllys Ingersoll
> <wyllys.ingersoll-yfee5r9JHcEqDJ6do+/SaQ@public.gmane.org> wrote:
>> I have an inconsistent PG that I cannot seem to get to repair cleanly.
>> I can find the 3 objects in question and they all have the same size
>> and md5sum, but yet whenever I repair it, it is reported as an error
>> "failed to pick suitable auth object".
>>
>> Any suggestions for fixing or workaround this issue to resolve the
>> inconsistency?
>>
>> Ceph 10.2.9
>> Ubuntu 16.04.2
>>
>>
>> 2017-09-26 09:54:03.123938 7fd31048e700 -1 log_channel(cluster) log
>> [ERR] : 1.5b8 shard 7: soid 1:1daab06b:::100004d6662.00000000:head
>> data_digest 0x923deb74 != data_digest 0x23f10be8 from auth oi
>> 1:1daab06b:::100004d6662.00000000:head(204442'221517
>> client.5654254.1:2371279 dirty|data_digest|omap_digest s 1421644 uv
>> 203993 dd 23f10be8 od ffffffff alloc_hint [0 0])
>> 2017-09-26 09:54:03.123944 7fd31048e700  0 log_channel(cluster) do_log
>> log to syslog
>> 2017-09-26 09:54:03.123999 7fd31048e700 -1 log_channel(cluster) log
>> [ERR] : 1.5b8 shard 26: soid 1:1daab06b:::100004d6662.00000000:head
>> data_digest 0x923deb74 != data_digest 0x23f10be8 from auth oi
>> 1:1daab06b:::100004d6662.00000000:head(204442'221517
>> client.5654254.1:2371279 dirty|data_digest|omap_digest s 1421644 uv
>> 203993 dd 23f10be8 od ffffffff alloc_hint [0 0])
>> 2017-09-26 09:54:03.124005 7fd31048e700  0 log_channel(cluster) do_log
>> log to syslog
>> 2017-09-26 09:54:03.124013 7fd31048e700 -1 log_channel(cluster) log
>> [ERR] : 1.5b8 shard 44: soid 1:1daab06b:::100004d6662.00000000:head
>> data_digest 0x923deb74 != data_digest 0x23f10be8 from auth oi
>> 1:1daab06b:::100004d6662.00000000:head(204442'221517
>> client.5654254.1:2371279 dirty|data_digest|omap_digest s 1421644 uv
>> 203993 dd 23f10be8 od ffffffff alloc_hint [0 0])
>> 2017-09-26 09:54:03.124015 7fd31048e700  0 log_channel(cluster) do_log
>> log to syslog
>> 2017-09-26 09:54:03.124022 7fd31048e700 -1 log_channel(cluster) log
>> [ERR] : 1.5b8 soid 1:1daab06b:::100004d6662.00000000:head: failed to
>> pick suitable auth object
>> 2017-09-26 09:54:03.124023 7fd31048e700  0 log_channel(cluster) do_log
>> log to syslog
>> 2017-09-26 09:56:14.461015 7fd31048e700 -1 log_channel(cluster) log
>> [ERR] : 1.5b8 deep-scrub 3 errors
>> 2017-09-26 09:56:14.461021 7fd31048e700  0 log_channel(cluster) do_log
>> log to syslog
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--------------9C8D105355CD934850E61BBD
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <p>The following is based on the discussion in: 
      <a class="moz-txt-link-freetext" href="http://tracker.ceph.com/issues/21388">http://tracker.ceph.com/issues/21388</a></p>
    <p style="color: rgb(55, 66, 74); font-family: Helvetica, Arial,
      sans-serif; font-size: 12px; font-style: normal;
      font-variant-caps: normal; font-weight: normal; letter-spacing:
      normal; orphans: auto; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: auto;
      word-spacing: 0px; -webkit-text-size-adjust: auto;
      -webkit-text-stroke-width: 0px;"><font size="+1">------<br>
      </font></p>
    <p style="color: rgb(55, 66, 74); font-family: Helvetica, Arial,
      sans-serif; font-size: 12px; font-style: normal;
      font-variant-caps: normal; font-weight: normal; letter-spacing:
      normal; orphans: auto; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: auto;
      word-spacing: 0px; -webkit-text-size-adjust: auto;
      -webkit-text-stroke-width: 0px;"><font size="+1">There is a
        particular scenario which if identified can be repaired
        manually. In this case the automatic repair rejects all copies
        because none match the selected_object_info thus setting
        data_digest_mismatch_oi on all shards.</font></p>
    <p style="color: rgb(55, 66, 74); font-family: Helvetica, Arial,
      sans-serif; font-size: 12px; font-style: normal;
      font-variant-caps: normal; font-weight: normal; letter-spacing:
      normal; orphans: auto; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: auto;
      word-spacing: 0px; -webkit-text-size-adjust: auto;
      -webkit-text-stroke-width: 0px;"><font size="+1">Doing the
        following should produce list-inconsistent-obj information:</font></p>
    <p style="color: rgb(55, 66, 74); font-family: Helvetica, Arial,
      sans-serif; font-size: 12px; font-style: normal;
      font-variant-caps: normal; font-weight: normal; letter-spacing:
      normal; orphans: auto; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: auto;
      word-spacing: 0px; -webkit-text-size-adjust: auto;
      -webkit-text-stroke-width: 0px;"><font size="+1">$ ceph pg
        deep-scrub 1.0<br>
        (Wait for scrub to finish)<br>
        $ rados list-inconsistent-obj 1.0 --format=json-pretty</font></p>
    <font face="Helvetica, Arial, sans-serif"><span style="color:
        rgb(55, 66, 74); font-size: 12px; font-style: normal;
        font-variant-caps: normal; font-weight: normal; letter-spacing:
        normal; text-align: start; text-indent: 0px; text-transform:
        none; white-space: normal; word-spacing: 0px;
        -moz-text-size-adjust: auto; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); display: inline !
        important; float: none;">Requirements:</span></font>
    <ol style="margin-top: 0px; margin-bottom: 1em; color: rgb(55, 66,
      74); font-family: Helvetica, Arial, sans-serif; font-size: 12px;
      font-style: normal; font-variant-caps: normal; font-weight:
      normal; letter-spacing: normal; orphans: auto; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto;
      -webkit-text-stroke-width: 0px;">
      <li><font size="+1">data_digest_mismatch_oi is set on all shards
          make it unrepairable</font></li>
      <li><font size="+1">union_shard_errors has only
          data_digest_mismatch_oi listed, no other issues involved</font></li>
      <li><font size="+1">Object "errors" is empty { "inconsistent": [ {
          ..."errors": []....} ] } which means the data_digest value is
          the same on all shards (0x2d4a11c2 in the example below)</font></li>
      <li><font size="+1">No down OSDs which might have
          different/correct data</font></li>
    </ol>
    <p style="color: rgb(55, 66, 74); font-family: Helvetica, Arial,
      sans-serif; font-size: 12px; font-style: normal;
      font-variant-caps: normal; font-weight: normal; letter-spacing:
      normal; orphans: auto; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: auto;
      word-spacing: 0px; -webkit-text-size-adjust: auto;
      -webkit-text-stroke-width: 0px;"><font size="+1">To fix use rados
        get/put followed by a deep-scrub to clear the "inconsistent" pg
        state.  Use -b option with a value smaller than the file size so
        that the read doesn't compare the digest and return EIO.<br>
      </font></p>
    <ol>
      <li><font size="+1">rados -p pool -b 10240 get mytestobject
          tempfile</font></li>
      <li><font size="+1">rados -p pool put mytestobject tempfile</font></li>
      <li><font size="+1">ceph pg deep-scrub 1.0<br>
        </font></li>
    </ol>
    <p style="color: rgb(55, 66, 74); font-family: Helvetica, Arial,
      sans-serif; font-size: 12px; font-style: normal;
      font-variant-caps: normal; font-weight: normal; letter-spacing:
      normal; orphans: auto; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: auto;
      word-spacing: 0px; -webkit-text-size-adjust: auto;
      -webkit-text-stroke-width: 0px;"><br>
    </p>
    <p style="color: rgb(55, 66, 74); font-family: Helvetica, Arial,
      sans-serif; font-size: 12px; font-style: normal;
      font-variant-caps: normal; font-weight: normal; letter-spacing:
      normal; orphans: auto; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: auto;
      word-spacing: 0px; -webkit-text-size-adjust: auto;
      -webkit-text-stroke-width: 0px;"><font size="+1">Here is an
        example list-inconsistent-obj output of what this scenario looks
        like:<br>
      </font></p>
    <pre style="font-family: Consolas, Menlo, &quot;Liberation Mono&quot;, Courier, monospace; margin: 1em 1em 1em 1.6em; padding: 8px; background-color: rgb(250, 250, 250); border: 1px solid rgb(226, 226, 226); border-top-left-radius: 3px; border-top-right-radius: 3px; border-bottom-right-radius: 3px; border-bottom-left-radius: 3px; width: auto; overflow-x: auto; overflow-y: hidden; color: rgb(55, 66, 74); font-size: 12px; font-style: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;"><font size="+1">{
  "inconsistents": [
    {
      "shards": [
        {
          "data_digest": "0x2d4a11c2",
          "omap_digest": "0xf5fba2c6",
          "size": 143456,
          "errors": [
            "data_digest_mismatch_oi" 
          ],
          "osd": 0,
          "primary": true
        },
        {
          "data_digest": "0x2d4a11c2",
          "omap_digest": "0xf5fba2c6",
          "size": 143456,
          "errors": [
            "data_digest_mismatch_oi" 
          ],
          "osd": 1,
          "primary": false
        },
        {
          "data_digest": "0x2d4a11c2",
          "omap_digest": "0xf5fba2c6",
          "size": 143456,
          "errors": [
            "data_digest_mismatch_oi" 
          ],
          "osd": 2,
          "primary": false
        }
      ],
      "selected_object_info": "3:ce3f1d6a::: mytestobject:head(47'54 osd.0.0:53 dirty|omap|data_digest|omap_digest s 143456 uv 3 dd 2ddbf8f5 od f5fba2c6 alloc_hint [0 0 0])",
      "union_shard_errors": [
        "data_digest_mismatch_oi" 
      ],
      "errors": [
      ],
      "object": {
        "version": 3,
        "snap": "head",
        "locator": "",
        "nspace": "",
        "name": "mytestobject" 
      }
    }
  ],
  "epoch": 103443
}</font></pre>
    <br>
    David<br>
    <br>
    <div class="moz-cite-prefix">On 9/26/17 10:55 AM, Gregory Farnum
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAJ4mKGbx1pEWd0b+99t0tmjLanjSUe9OmChWoTgthAkqyVurGA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <pre wrap="">[ Re-send due to HTML email part]

IIRC, this is because the object info and the actual object disagree
about what the checksum should be. I don't know the best way to fix it
off-hand but it's been discussed on the list (try searching for email
threads involving David Zafman).
-Greg

On Tue, Sep 26, 2017 at 7:03 AM, Wyllys Ingersoll
<a class="moz-txt-link-rfc2396E" href="mailto:wyllys.ingersoll-yfee5r9JHcEqDJ6do+/SaQ@public.gmane.org">&lt;wyllys.ingersoll-yfee5r9JHcEqDJ6do+/SaQ@public.gmane.org&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">I have an inconsistent PG that I cannot seem to get to repair cleanly.
I can find the 3 objects in question and they all have the same size
and md5sum, but yet whenever I repair it, it is reported as an error
"failed to pick suitable auth object".

Any suggestions for fixing or workaround this issue to resolve the
inconsistency?

Ceph 10.2.9
Ubuntu 16.04.2


2017-09-26 09:54:03.123938 7fd31048e700 -1 log_channel(cluster) log
[ERR] : 1.5b8 shard 7: soid 1:1daab06b:::100004d6662.00000000:head
data_digest 0x923deb74 != data_digest 0x23f10be8 from auth oi
1:1daab06b:::100004d6662.00000000:head(204442'221517
client.5654254.1:2371279 dirty|data_digest|omap_digest s 1421644 uv
203993 dd 23f10be8 od ffffffff alloc_hint [0 0])
2017-09-26 09:54:03.123944 7fd31048e700  0 log_channel(cluster) do_log
log to syslog
2017-09-26 09:54:03.123999 7fd31048e700 -1 log_channel(cluster) log
[ERR] : 1.5b8 shard 26: soid 1:1daab06b:::100004d6662.00000000:head
data_digest 0x923deb74 != data_digest 0x23f10be8 from auth oi
1:1daab06b:::100004d6662.00000000:head(204442'221517
client.5654254.1:2371279 dirty|data_digest|omap_digest s 1421644 uv
203993 dd 23f10be8 od ffffffff alloc_hint [0 0])
2017-09-26 09:54:03.124005 7fd31048e700  0 log_channel(cluster) do_log
log to syslog
2017-09-26 09:54:03.124013 7fd31048e700 -1 log_channel(cluster) log
[ERR] : 1.5b8 shard 44: soid 1:1daab06b:::100004d6662.00000000:head
data_digest 0x923deb74 != data_digest 0x23f10be8 from auth oi
1:1daab06b:::100004d6662.00000000:head(204442'221517
client.5654254.1:2371279 dirty|data_digest|omap_digest s 1421644 uv
203993 dd 23f10be8 od ffffffff alloc_hint [0 0])
2017-09-26 09:54:03.124015 7fd31048e700  0 log_channel(cluster) do_log
log to syslog
2017-09-26 09:54:03.124022 7fd31048e700 -1 log_channel(cluster) log
[ERR] : 1.5b8 soid 1:1daab06b:::100004d6662.00000000:head: failed to
pick suitable auth object
2017-09-26 09:54:03.124023 7fd31048e700  0 log_channel(cluster) do_log
log to syslog
2017-09-26 09:56:14.461015 7fd31048e700 -1 log_channel(cluster) log
[ERR] : 1.5b8 deep-scrub 3 errors
2017-09-26 09:56:14.461021 7fd31048e700  0 log_channel(cluster) do_log
log to syslog
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to <a class="moz-txt-link-abbreviated" href="mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>
More majordomo info at  <a class="moz-txt-link-freetext" href="http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org/majordomo-info.html</a>
</pre>
      </blockquote>
      <pre wrap="">--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to <a class="moz-txt-link-abbreviated" href="mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>
More majordomo info at  <a class="moz-txt-link-freetext" href="http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org/majordomo-info.html</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------9C8D105355CD934850E61BBD--

--===============4415211428040333642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============4415211428040333642==--
