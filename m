From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH, v2 06/11] rbd: add read_only rbd map option
Date: Fri, 07 Sep 2012 15:36:34 -0500
Message-ID: <504A5AD2.1090107@inktank.com>
References: <5037AB20.4000103@inktank.com> <5037AD10.9010203@inktank.com> <5048C2F8.90505@inktank.com> <alpine.DEB.2.00.1209070844190.9861@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61361 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755954Ab2IGUgi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 16:36:38 -0400
Received: by ieje11 with SMTP id e11so5743376iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 13:36:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209070844190.9861@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 09/07/2012 10:45 AM, Sage Weil wrote:
> On Thu, 6 Sep 2012, Alex Elder wrote:
>> Add the ability to map an rbd image read-only, by specifying either
>> "read_only" or "ro" as an option on the rbd "command line."  Also
>> allow the inverse to be explicitly specified using "read_write" or
>> "rw".
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>> v2: - Made the read_only/ro flag explicitly make the mapping
>>       read-only rather than having it toggle.
>>     - Added read_write/rw flags to allow a writable mapping to
>>       be explicitly requested.  Snapshot mappings are silently
>>       mapped read-only (even if read_write was requested).
> 
> If rw is the default, and rw is silently ignored if the image itself is a 
> snapshot, what is the value in rw?  Would it make more sense to fail with 
> EROFS if you specify rw on a snapshot (or otherwise read-only image)?

I explicitly called this out because what I wanted to do was simply too
hard.

Namely:
- default for base image map would be read-write
- default for snapshot map would be read-only
- attempt to map snapshot read-write would be met with a "ignoring"
  warning

But the way the argument parsing is structured, you never have all the
information you want at the right time to do the above.  So I punted
and just decided attempts to read-write map a snapshot would be silently
ignored.

I'll take a look at simply failing on a read-write mount of a snapshot
and if it's workable I'll do that.

					-Alex

PS  As I told to Josh separately, one of the reasons I even put in the
    read-only option in the first place is to have a reason to preserve
    the argument parsing infrastructure.  And that's why it gets added
    at this position in the series--so that code remains after the next
    patch, which removes the only other option (notify_timeout).  But it
    also seemed like a (marginally) useful option either way.

> sage
> 
>>
>>  drivers/block/rbd.c |   28 ++++++++++++++++++++++++----
>>  1 file changed, 24 insertions(+), 4 deletions(-)
>>
>> Index: b/drivers/block/rbd.c
>> ===================================================================
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -69,7 +69,8 @@
>>  #define DEV_NAME_LEN		32
>>  #define MAX_INT_FORMAT_WIDTH	((5 * sizeof (int)) / 2 + 1)
>>
>> -#define RBD_NOTIFY_TIMEOUT_DEFAULT 10
>> +#define RBD_NOTIFY_TIMEOUT_DEFAULT	10
>> +#define RBD_READ_ONLY_DEFAULT		false
>>
>>  /*
>>   * block device image metadata (in-memory version)
>> @@ -91,6 +92,7 @@ struct rbd_image_header {
>>
>>  struct rbd_options {
>>  	int	notify_timeout;
>> +	bool	read_only;
>>  };
>>
>>  /*
>> @@ -176,7 +178,7 @@ struct rbd_device {
>>  	u64                     snap_id;	/* current snapshot id */
>>  	/* whether the snap_id this device reads from still exists */
>>  	bool                    snap_exists;
>> -	int                     read_only;
>> +	bool			read_only;
>>
>>  	struct list_head	node;
>>
>> @@ -351,12 +353,21 @@ enum {
>>  	/* int args above */
>>  	Opt_last_string,
>>  	/* string args above */
>> +	Opt_read_only,
>> +	Opt_read_write,
>> +	/* Boolean args above */
>> +	Opt_last_bool,
>>  };
>>
>>  static match_table_t rbd_opts_tokens = {
>>  	{Opt_notify_timeout, "notify_timeout=%d"},
>>  	/* int args above */
>>  	/* string args above */
>> +	{Opt_read_only, "read_only"},
>> +	{Opt_read_only, "ro"},		/* Alternate spelling */
>> +	{Opt_read_write, "read_write"},
>> +	{Opt_read_write, "rw"},		/* Alternate spelling */
>> +	/* Boolean args above */
>>  	{-1, NULL}
>>  };
>>
>> @@ -381,6 +392,8 @@ static int parse_rbd_opts_token(char *c,
>>  	} else if (token > Opt_last_int && token < Opt_last_string) {
>>  		dout("got string token %d val %s\n", token,
>>  		     argstr[0].from);
>> +	} else if (token > Opt_last_string && token < Opt_last_bool) {
>> +		dout("got Boolean token %d\n", token);
>>  	} else {
>>  		dout("got token %d\n", token);
>>  	}
>> @@ -389,6 +402,12 @@ static int parse_rbd_opts_token(char *c,
>>  	case Opt_notify_timeout:
>>  		rbd_opts->notify_timeout = intval;
>>  		break;
>> +	case Opt_read_only:
>> +		rbd_opts->read_only = true;
>> +		break;
>> +	case Opt_read_write:
>> +		rbd_opts->read_only = false;
>> +		break;
>>  	default:
>>  		BUG_ON(token);
>>  	}
>> @@ -407,6 +426,7 @@ static int rbd_get_client(struct rbd_dev
>>  	struct rbd_client *rbdc;
>>
>>  	rbd_opts->notify_timeout = RBD_NOTIFY_TIMEOUT_DEFAULT;
>> +	rbd_opts->read_only = RBD_READ_ONLY_DEFAULT;
>>
>>  	ceph_opts = ceph_parse_options(options, mon_addr,
>>  					mon_addr + mon_addr_len,
>> @@ -620,7 +640,7 @@ static int rbd_header_set_snap(struct rb
>>  		    sizeof (RBD_SNAP_HEAD_NAME))) {
>>  		rbd_dev->snap_id = CEPH_NOSNAP;
>>  		rbd_dev->snap_exists = false;
>> -		rbd_dev->read_only = 0;
>> +		rbd_dev->read_only = rbd_dev->rbd_opts.read_only;
>>  		if (size)
>>  			*size = rbd_dev->header.image_size;
>>  	} else {
>> @@ -632,7 +652,7 @@ static int rbd_header_set_snap(struct rb
>>  			goto done;
>>  		rbd_dev->snap_id = snap_id;
>>  		rbd_dev->snap_exists = true;
>> -		rbd_dev->read_only = 1;
>> +		rbd_dev->read_only = true;	/* No choice for snapshots */
>>  	}
>>
>>  	ret = 0;
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> 
> 

