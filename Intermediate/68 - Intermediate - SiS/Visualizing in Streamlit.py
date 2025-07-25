# Import python packages
import streamlit as st
from snowflake.snowpark.context import get_active_session

#  Write directly to the app
st.title("Frosty Friday Challenge 68 :snowflake:")
st.write(
    """Solution by Darko Monzio Compagnoni
    """
)

# Get the current credentials
session = get_active_session()

#  Create a dataframe querying the tables createdby parsing the json file
queried_df = session.sql("select * FROM spanish_speaking_countries")

#  Convert the dataframe into a Pandas dataframe
df = queried_df.to_pandas()

# Creating the bar chart
st.subheader("Spanish Speaking Countries by POP")
st.bar_chart(data=df, x="COUNTRY", y="POP2023")

# Creating a table
st.subheader("Visualizing data in a table")
st.dataframe(queried_data, use_container_width=True)
